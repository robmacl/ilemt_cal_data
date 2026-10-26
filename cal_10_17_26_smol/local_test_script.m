% Run at the end of run_tests().  With correct signs all the coil gains
% should be positive.
smol_dipole = load_cal_file('ld_dipole_hr_cal');
gains = [diag(smol_dipole.d_source_moment)' diag(smol_dipole.d_sensor_moment)'];
if (any(gains < 0))
  fprintf(1, ['Warning: negative coil gains [%s], probably a sign problem, ' ...
              'see local_cal_options.m\n'], num2str(gains, ' %.3g'));
end
