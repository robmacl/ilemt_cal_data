% Local check_poses() options for the EMOTO XYZ+Ry ("smol") setup.

% There is no separate test data yet, so check on the calibration data
% itself.  This shows how well the pose solution reproduces the calibration
% poses, not independent accuracy.
options.in_files = {'soZoutYup_seZoutYup_smol.dat'};

options.cal_file = 'smol_dipole_hr_cal';
