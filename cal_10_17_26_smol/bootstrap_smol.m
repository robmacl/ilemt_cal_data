function [cal] = bootstrap_smol (varargin)
% Make the initial calibration base_smol.mat for the EMOTO XYZ+Ry ("smol")
% setup from the nominal geometry.  Run with this directory as cwd.  Any
% arguments are key/value overrides for calibrate_options().
%
% base_smol.mat is kept here rather than in output/ so that
% run_tests('clean') doesn't delete it.  Then run_tests() does the
% calibrations and tests, see local_test_options.m.
%
% Nominal geometry at stage home (Ry = 0):
%  - Sensor axes in stage coordinates: sensor Z -> stage +Y, sensor Y ->
%    stage +Z, so sensor X -> stage -X.
%  - Source axes are parallel to the sensor axes, with the sensor in the
%    source +Z hemisphere, about 55 mm away along stage Y.
%  - The source mover and the sensor are both ZoutYup, so the fixture
%    motions from the file name (read_cal_data) supply both rotations, and
%    all the fixture transforms are nominally identity rotations.
%  - Ry is about stage Y (the line of sight), and the sensor is close to the
%    Ry axis, so the sensor fixture translation is ~0.

dist = 0.055;

% Sensor (and source) axes in stage coordinates.  This is a rotation of pi
% about (0 1 1)/sqrt(2), and is also the ZoutYup fixture motion for both
% source and sensor.
R_axes = [-1 0 0; 0 0 1; 0 1 0];

cal.d_source_pos = zeros(3);
cal.d_source_moment = eye(3);
cal.d_sensor_pos = zeros(3);
cal.d_sensor_moment = eye(3);
cal.q_source_pos = zeros(3);
cal.q_source_moment = zeros(3);
cal.q_sensor_pos = zeros(3);
cal.q_sensor_moment = zeros(3);
cal.q_source_distance = 0.004;
cal.q_sensor_distance = 0.0005;
cal.pin_quadrupole = true;
cal.source_fixture = zeros(1, 6);
% P = so_motion * st_fix * se_motion * se_fix, where at home so_motion and
% se_motion are both R_axes, and R_axes * R_axes = I.  At home we want
% P = [I [0 0 dist]'], so st_fix is a pure translation along stage Y and
% se_fix is identity.
cal.stage_fixture = [0 dist 0 0 0 0];
cal.sensor_fixture = zeros(1, 6);

% Fit sensor gains from the home coupling diagonal, with source gains 1.
options = calibrate_options([], varargin);
[motions, couplings] = read_cal_data(options);
home_ix = find(all(motions(:, 13:18) == 0, 2), 1);
measured = real_coupling(couplings(:, :, home_ix));
so_motion = vector2tr(motions(home_ix, 1:6));
assert(norm(so_motion(1:3, 1:3) - R_axes) < 1e-12);
se_motion = vector2tr(motions(home_ix, 7:12));
assert(norm(se_motion(1:3, 1:3) - R_axes) < 1e-12);
P = so_motion * pose2trans(cal.stage_fixture) * se_motion * pose2trans(cal.sensor_fixture);
pred = forward_kinematics(P, cal);
cal.d_sensor_moment = diag(diag(measured) ./ diag(pred));

res = calibrate_objective(calibration2state(cal), motions, couplings, options);
fprintf(1, 'Initial sum square residue: %.4f\n', sum(res(:).^2));
save_calibration(cal, 'base_smol.mat');
