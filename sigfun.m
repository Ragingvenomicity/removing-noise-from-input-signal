clc
clear all
haadu=audioread('C:\Users\agang\Desktop\Voice.wav');
haadu_frq=haadu(16600:16932);
figure
plot(haadu_frq)
title('voice')
raaga=audioread('C:\Users\agang\Desktop\Noise.wav');
raaga_frq=raaga(16600:16932);
figure
plot(raaga_frq)
title('Noise')
thala=(haadu_frq+raaga_frq);
figure
plot(thala)
title('superimposed')
sound(thala)
Len=length(haadu_frq);
Len_1=length(thala);
wavename='db4';
level=3;
[cA,cD]= dwt(thala,wavename);
App=idwt(cA,[],wavename,Len_1);
Det=idwt([],cD,wavename,Len_1);
[c1,l1]=wavedec(haadu_frq,level,wavename);
[c,l]=wavedec(thala,level,wavename);
cA3 = appcoef(c,l,wavename,level);
[cD1,cD2,cD3]=detcoef(c,l,[1,2,3]);
[App,Det] = dwt(thala,wavename);
noise_level = median (abs(Det))/0.6745;
Threshold=sqrt(2*log(length(thala)))*noise_level;
[thr,sorh,keepapp] = ddencmp('den','wv',thala);
sig_denoise=wdencmp('gbl',thala,wavename,level,Threshold,sorh,keepapp);
figure
plot(sig_denoise)
title('denoised');
[c2,l2]=wavedec(sig_denoise,level,wavename);
App3 = wrcoef('a',c2,l2,wavename,1);
Det1 = wrcoef('d',c2,l2,wavename,1);
Det2 = wrcoef('d',c2,l2,wavename,2);
Det3 = wrcoef('d',c2,l2,wavename,3);
SNR_NSIG=snr(thala);
SNR_NSIG
DENOISED_SNR=snr(sig_denoise);
DENOISED_SNR
FINAL_SNR=DENOISED_SNR-SNR_NSIG;
FINAL_SNR
