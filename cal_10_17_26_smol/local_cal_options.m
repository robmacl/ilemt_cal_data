% Local calibration options for the EMOTO XYZ+Ry stage setup ("smol").
% From nothing: bootstrap_smol() makes base_smol.mat, then run_tests() does
% the calibrations and tests in local_test_options.m.
options.source = 'emoto';
options.sensor = 'premo_3dv09';

% Source mover is ZoutYup so that the source is aligned with the sensor.  The
% sensor is mounted on the boom with Z out and Y up, so it is also ZoutYup.
% Patterns:
%  'smol': +/-20 mm XYZ (3^3) x Ry {-45 0 45}, 86 points (2026-10-17)
%  'ld':   +/-20 mm XYZ (5^3) x Ry {-90 -45 0 45 90}, 632 points (2026-10-25)
% Calibrate from ld; smol is the test data (see local_check_options.m).
options.source_fixtures = {'soZoutYup'};
options.sensor_fixtures = {'seZoutYup'};
options.data_patterns = {'ld'};

% compensate_stage() tables are for the old 200 mm XYZRz stage.
options.compensate_stage = false;

% Only one source and one sensor fixturing, so:
%  - Source fixture is redundant with the stage fixture, so it is not in
%    options.optimize (the default list is otherwise what we want).
%  - The only rotation is Ry, about the stage Y axis, so sensor fixture
%    translation along that axis is redundant with the stage fixture.  With
%    seZoutYup the stage Y axis is se_fix Z, so freeze z_se_fix.  (With
%    seYoutZup it would be y_se_fix.  Freezing the wrong one lets the fit run
%    away along the redundant direction.)
options.optimize = {'d_so_pos' 'd_so_mo' 'd_se_pos' 'd_se_mo' 'st_fix' 'se_fix'};
options.freeze = {'d_so_z_gain' 'd_so_y_co' 'd_se_y_co' 'z_se_fix'};

% PROVISIONAL sign fix.  Taken as-is, the data only fits with mirrored
% (left-handed) coil frames: the Y moments of both source and sensor come out
% negative.  That is what an odd number of sensor input sign errors looks
% like after "Ref cal" (D*C*D, see doc.txt "With new source or sensor
% hardware").  Flipping the Y row and column undoes the mirror.  This can't
% tell which sensor channel is wrong, and a stage handedness error (a
% translation sign plus the Ry sign) would look the same.  Check the hardware
% with the freehand sign test, then fix the ilemt_ui input signs and drop
% this for new data.
% All the data in this directory was taken with the same hardware setup.
options.source_signs = {'\.dat$' [1 -1 1]};
options.sensor_signs = {'\.dat$' [1 -1 1]};
