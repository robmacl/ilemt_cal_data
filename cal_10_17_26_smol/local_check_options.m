% Local check_poses() options for the EMOTO XYZ+Ry ("smol") setup.

% Calibration is from the ld data, so test on the smol data.  It was taken a
% week earlier, and the setup has shifted ~1 mm since, see the 'stage fix'
% variant in local_test_options.m.
options.in_files = {'soZoutYup_seZoutYup_smol.dat'};

% Octupole + sensor anisotropy + stage Y scale model, see local_test_options.m.
options.cal_file = 'ld_oct_hr_cal';

% Initialize the 'optimize' pose solution with Kim18 using the concentric
% calibration.  Without this, some poses converge to wrong local minima
% (~3.5 mm, 3.5 deg errors) with residuals just under valid_threshold, so the
% retry doesn't happen.
options.concentric_cal_file = 'ld_concentric_hr_cal';

% Report errors in source coordinates.  The sensor is mounted rotated ~180
% degrees wrt. the stage, so in stage coordinates the desired orientations
% are rotation vectors near the 180 degree wrap, and the rot plots are hard
% to read.  In source coordinates they are just Ry about the line of sight.
options.stage_coords = false;
