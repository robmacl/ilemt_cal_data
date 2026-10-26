%% local test definitions for the smol setup, included by testing/run_tests.m
%
% base_smol.mat comes from bootstrap_smol().  First a concentric calibration
% from the nominal geometry, then the dipole calibration from that, both from
% the ld data (local_cal_options.m).  The tests are on the smol data
% (local_check_options.m).

% {cal_mode base_calibration option*}
cal_runs = {
    {'default', 'base_smol', 'concentric', true, ...
     'out_file', 'output/ld_concentric_hr_cal'}
    {'default', 'ld_concentric_hr_cal', ...
     'out_file', 'output/ld_dipole_hr_cal'}
    };

% cp_runs{:, 1} is the cal_file
% cp_runs(:, 2:end} are additional options
cp_runs = {
    {'ld_concentric_hr_cal'}
    {'ld_dipole_hr_cal'}
    };

% Variants are different options that we test on each run.  'stage fix'
% reoptimizes the stage fixture on the test data, to take out the setup
% shift between the calibration and test data.  That uses the test data's
% ground truth, so it is not a strictly independent test.
cp_variants = {
    'default' {}
    'nocorrect' {'linear_correction', false}
    'stage fix' {'optimize_fixtures', {'stage'}}
    };
