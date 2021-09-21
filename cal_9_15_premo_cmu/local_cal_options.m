options.source = 'CMU';
options.sensor = 'premo';

%{
soYoutZup_seZinXdown_sweep.dat
soYoutZup_seZinYup_sweep.dat
soYoutZup_seYoutZup_sweep.dat
soXinYup_seYoutZup_md.dat
soXinYup_seYoutZup_ld.dat
soZoutYup_seYoutZup_ld.dat
soZoutYup_seYoutZup_md.dat
soXoutZup_seYoutZup_md.dat
%}

% Got the source signs messed up in some of this data, probably from doing
% "Ref cal" in the wrong source fixture.
% ### other files may be wrong too, have not tried them all.
options.source_signs = {
    'soZoutYup_seYoutZup_(md|ld).dat' [-1 -1 1]
    'soXoutZup_seYoutZup_md.dat' [-1 -1 1]
    };

    
    