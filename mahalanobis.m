function y = mahalanobis(rol, pit, gx, gy)

A = [((rol + 3976749/33554432)*((5494425*conj(gx))/524288 - (9851079*conj(gy))/8388608 - (10412009*conj(pit))/2097152 + (2591399*conj(rol))/65536 + 9783579714513555/2251799813685248) + (pit + 8690151/134217728)*((10127589*conj(gy))/524288 - (5660003*conj(gx))/1048576 + (11875479*conj(pit))/262144 - (10412009*conj(rol))/2097152 + 46310391330099887/18014398509481984) + (gy + 12377297/1073741824)*((3221125*conj(gy))/262144 - (11255675*conj(gx))/4194304 + (10127589*conj(pit))/524288 - (9851079*conj(rol))/8388608 + 90420971964774535/72057594037927936) + (gx - 10741093/17179869184)*((7019957*conj(gx))/1048576 - (11255675*conj(gy))/4194304 - (5660003*conj(pit))/1048576 + (5494425*conj(rol))/524288 + 15445842629175915/18014398509481984))^(1/2)
     ((gy - 5817261/134217728)*((10185763*conj(gy))/65536 - (11075985*conj(gx))/262144 + (15568711*conj(pit))/2097152 - (5995979*conj(rol))/524288 + 12969875432915581/2251799813685248) - (gx - 355337/2097152)*((11075985*conj(gy))/262144 - (5466607*conj(gx))/262144 + (3320689*conj(pit))/524288 - (11765093*conj(rol))/1048576 + 3908451881926187/562949953421312) - (rol - 15764213/33554432)*((5995979*conj(gy))/524288 - (11765093*conj(gx))/1048576 + (8078205*conj(pit))/262144 - (4716397*conj(rol))/131072 + 5112110008589491/281474976710656) + (pit - 5186917/1073741824)*((15568711*conj(gy))/2097152 - (3320689*conj(gx))/524288 + (860171*conj(pit))/8192 - (8078205*conj(rol))/262144 + 4143820521716293/281474976710656))^(1/2)
     ((pit + 15020141/134217728)*((10497079*conj(gy))/2097152 - (4484707*conj(gx))/2097152 + (3647855*conj(pit))/8192 - (1104951*conj(rol))/65536 + 40896555554562451/1125899906842624) - (gy + 5126821/536870912)*((8782083*conj(gx))/262144 - (14568181*conj(gy))/65536 - (10497079*conj(pit))/2097152 + (1829575*conj(rol))/65536 + 7238956860440845/281474976710656) + (rol + 3266789/4194304)*((2755005*conj(gx))/131072 - (1829575*conj(gy))/65536 - (1104951*conj(pit))/65536 + (16069711*conj(rol))/262144 + 1751077767287169/35184372088832) + (gx + 3333941/16777216)*((7933573*conj(gx))/524288 - (8782083*conj(gy))/262144 - (4484707*conj(pit))/2097152 + (2755005*conj(rol))/131072 + 5297003045878043/281474976710656))^(1/2)
     ((pit - 9296061/16777216)*((4978299*conj(gx))/131072 + (4931653*conj(gy))/262144 + (3523723*conj(pit))/65536 - (2106909*conj(rol))/131072 - 5001408301824605/140737488355328) - (rol + 2523499/16777216)*((8241023*conj(gx))/262144 + (3702771*conj(gy))/262144 + (2106909*conj(pit))/131072 - (8390099*conj(rol))/16384 - 24884812724015137/281474976710656) + (gy - 12842569/67108864)*((9633123*conj(gx))/1048576 + (3409337*conj(gy))/262144 + (4931653*conj(pit))/262144 - (3702771*conj(rol))/262144 - 16856248355367821/1125899906842624) + (gx + 7715441/1073741824)*((9667737*conj(gx))/16384 + (9633123*conj(gy))/1048576 + (4978299*conj(pit))/131072 - (8241023*conj(rol))/262144 - 1639004319664199/70368744177664))^(1/2)
     ((pit + 341227/524288)*((8671379*conj(gx))/4194304 + (4501155*conj(gy))/262144 + (14224487*conj(pit))/262144 - (9053229*conj(rol))/524288 + 157272209830468613/4503599627370496) + (gx + 7365767/1073741824)*((5791037*conj(gx))/8192 + (4800145*conj(gy))/131072 + (8671379*conj(pit))/4194304 + (14061125*conj(rol))/262144 + 315279504888237/17592186044416) + (gy + 15602117/134217728)*((4800145*conj(gx))/131072 + (7677495*conj(gy))/524288 + (4501155*conj(pit))/262144 + (1256681*conj(rol))/262144 + 1941656837924653/140737488355328) + (rol + 4672633/33554432)*((14061125*conj(gx))/262144 + (1256681*conj(gy))/262144 - (9053229*conj(pit))/524288 + (4562783*conj(rol))/8192 + 18928974390009035/281474976710656))^(1/2)];

a = min(A);
y = find(A==a);
classe = find(A==a);
end