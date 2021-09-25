if (options.ishigh)
  options.concentric_cal_file = 'XYZ_concentric_hr_cal';
else
  options.concentric_cal_file = 'XYZ_concentric_lr_cal';
  options.valid_threshold = 1e-6;
end
