%% local test definitions, included by test_script.m

% We don't have 'md' in the source fixtures in this dataset, so include
% 'source' in '_all' calibration.  And we only have one additional source
% fixture in the 'ld', but oh well..

% {cal_mode base_calibration option*}
% 
% First we have to bootstrap the XYZ source fixture because base_calibration
% is only an initial value, and XYZ w/o source fixture data can't solve the
% source fixture.  We don't want to leave anything from base_calibration in
% our final results.
%
% This consideration really only has to do with accuracy testing using the
% calibration-time fixture transforms, and in particular the calibration
% paper's desire to test the non-source-fixture calibration with source
% fixture test data.  What we do is first XYZ calibrate with the initial
% source fixture (forcing any source fixture error into the stage fixture),
% then optimize the source fixture (and stage fixture) only using the source
% fixture calibration data.  Then finally we run the XYZ calibration again
% using that source fixture, which should mainly serve to generate the
% output correction.
%
% Concentric calibration must be before any runs with output correction and
% the 'optimize' pose solution so that we can use Kim18 method to initialize
% the solution for the non-concentric calibrations.
cal_runs = {
    {'XYZ', 'base_calibration', 'out_file', 'output/XYZ_nosofix_hr_cal', 'correct_mode', 'none'}
    {'so_fixture_all', 'XYZ_nosofix_hr_cal', 'data_patterns', {'md', 'source'}}

    {'XYZ' 'so_fixture_all_hr_cal', 'concentric', true, 'correct_mode', 'none'}
    {'XYZ_all', 'XYZ_concentric_hr_cal', 'concentric', true, 'correct_mode', 'none', ...
     'data_patterns', {'md', 'source'}}

    {'XYZ', 'so_fixture_all_hr_cal'}
    {'XYZ_all', 'XYZ_hr_cal', 'data_patterns', {'md', 'source'}}

    {'XYZ', 'XYZ_hr_cal', 'ishigh', false, 'concentric', true, 'correct_mode', 'none'};
    {'XYZ', 'XYZ_hr_cal', 'ishigh', false}
    {'XYZ_all', 'XYZ_lr_cal', 'ishigh', false, ...
     'data_patterns', {'md', 'source'}}
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

% Variants are different options that we test on each run.
cp_variants = {
    'default' {}
    'nocorrect' {'linear_correction', false}
    'source fix' sf_options
    'sf nocorrect' {sf_options{:}, 'linear_correction', false}
    };
