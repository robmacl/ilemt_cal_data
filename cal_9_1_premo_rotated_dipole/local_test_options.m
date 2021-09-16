%% local test definitions, included by test_script.m

% {cal_mode base_calibration option*}
% 
% Concentric calibration is first so that we can use Kim18 method to
% initialize the solution for the non-concentric calibrations.  Linear
% correction (or at least DLT) does not work with this non-concentric
% source.
cal_runs = {
    {'XYZ' 'base_calibration', 'concentric', true, 'correct_mode', 'none'}
    {'XYZ_all', 'XYZ_concentric_hr_cal', 'concentric', true, 'correct_mode', 'none'}
    {'XYZ', 'base_calibration'}
    {'XYZ_all', 'XYZ_hr_cal'}
%    {'XYZ_all', 'XYZ_all_hr_cal', 'correct_mode', 'skew', 'out_file', 'XYZ_all_skew_hr_cal'}
    };

%cal_runs = {};

% cp_runs{:, 1} is the cal_file
% cp_runs(:, 2:end} are additional options
cp_runs = {
    {'XYZ_hr_cal'}
    {'XYZ_all_hr_cal'}
    {'XYZ_concentric_hr_cal', 'pose_solution', 'kim18'}
    {'XYZ_all_concentric_hr_cal', 'pose_solution', 'kim18'}
    };

% Variants are different options that we test on each run.
cp_variants = {
    'default' {}
    'nocorrect' {'linear_correction', false}
    'source fix' {'source_fixtures', {'soYoutZup' 'soXoutZup' 'soZoutYup' 'soXinYup'}}
    'sf nocorrect' {'source_fixtures', {'soYoutZup' 'soXoutZup' 'soZoutYup' 'soXinYup'}, 'linear_correction', false}
    };
