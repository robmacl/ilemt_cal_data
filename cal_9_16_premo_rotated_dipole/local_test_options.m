%% local test definitions, included by test_script.m

% {cal_mode base_calibration option*}
% 
% Concentric calibration is first so that we can use Kim18 method to
% initialize the solution for the non-concentric calibrations.  Linear
% correction (or at least DLT) does not work with this non-concentric
% source.
cal_runs = {
    {'XYZ', 'base_calibration', 'out_file', 'XYZ_nosofix_hr_cal', 'correct_mode', 'none'}
    {'so_fixture_all', 'XYZ_nosofix_hr_cal'}

    {'XYZ' 'so_fixture_all_hr_cal', 'concentric', true, 'correct_mode', 'none'}
    {'XYZ_all', 'XYZ_concentric_hr_cal', 'concentric', true, 'correct_mode', 'none'}

    {'XYZ', 'so_fixture_all_hr_cal'}
    {'XYZ_all', 'XYZ_hr_cal'}

    {'XYZ', 'XYZ_hr_cal', 'ishigh', false, 'concentric', true, 'correct_mode', 'none'};
    {'XYZ', 'XYZ_hr_cal', 'ishigh', false}
    {'XYZ_all', 'XYZ_lr_cal', 'ishigh', false}
    };

% cp_runs{:, 1} is the cal_file
% cp_runs(:, 2:end} are additional options
cp_runs = {
    {'XYZ_hr_cal'}
    {'XYZ_all_hr_cal'}
    {'XYZ_concentric_hr_cal', 'pose_solution', 'kim18'}
    {'XYZ_all_concentric_hr_cal', 'pose_solution', 'kim18'}
    {'XYZ_lr_cal', 'ishigh', false}
    {'XYZ_all_lr_cal', 'ishigh', false}
    };

% Options for the "source fixture" variant.
sf_options = {'source_fixtures', {'soYoutZup' 'soXoutZup' 'soZoutYup' 'soXinYup'}};
% oops, soXinYup is toast
%sf_options = {'source_fixtures', {'soYoutZup' 'soXoutZup' 'soZoutYup'}};

cp_opts = {cp_opts{:}, 'optimize_fixtures', {'source'}, 'discard_invalid', true};

% Variants are different options that we test on each run.
cp_variants = {
    'default' {}
    'nocorrect' {'linear_correction', false}
    'source fix' sf_options
    'sf nocorrect' {sf_options{:}, 'linear_correction', false}
    };
