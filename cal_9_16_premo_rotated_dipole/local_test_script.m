% Run sweep linearity test
%cal_file = '../cal_9_24_premo_rotated_dipole/output/XYZ_hr_cal';
close all;
cal_file = 'XYZ_hr_cal';
check_poses('cal_file', cal_file, ...
            'reports', {'overall', 'sweep'}, ...
            'data_patterns', {'sweep'}, ...
            'optimize_fixtures', {'stage', 'sensor'});
figure(1)
savefig('output/xyz_linearity');
figure(2)
savefig('output/RxRyRz_linearity');
figure(3)
savefig('output/Rz_response');
