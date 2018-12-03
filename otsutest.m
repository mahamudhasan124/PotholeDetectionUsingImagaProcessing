function [k]=otsu(a)
b=a;
[c,d]=size(b);
b=reshape(b,[],1);
[m,n]=size(b);
weightb=zeros(3,256);
weightf=zeros(3,256);
r=1;
l=1;
for T=0:255
    [wb,wf,mb,mf,vrb,vrf]=cal(T,b,m);
    weightb(1,r)=wb;
    weightb(2,r)=mb;
    weightb(3,r)=vrb;
    r=r+1;
    weightf(1,l)=wf;
    weightf(2,l)=mf;
    weightf(3,l)=vrf;
    l=l+1;
end
%Within class variance
wcv=zeros(1,256);
for g=1:256
wcv(1,g)=((weightb(1,g)*weightb(3,g))+((weightf(1,g)*weightf(3,g))));
end
% min(wcv)
[threshold_value,val]=min(wcv);
 tval=(val-1)/256;
%  b=imresize(b,[c d])
 a=im2bw(a,tval);
k= medfilt2(a,[25 25]);
end

function [wb,wf,mb,mf,vrb,vrf]=cal(i,b,m)
  % weight
  wb=0;
  wf=0;
  mb=0;
  mf=0;
  b=double(b);
  vb=0;vf=0;
  vrb=0;
  vrf=0;
  for s=1:m
      if(b(s,1)<(i))
          wb=wb+1;
          mb=mb+b(s,1);
             else
          wf=wf+1;
          mf=mf+b(s,1);
       end
  end
  %mean
  if(wb==0)
      mb=0;
   mf=mf/wf;
  elseif(wf==0)
  wf=0;
  mb=mb/wb;
  else
  mb=mb/wb;
  mf=mf/wf;
  end
  %weight
  wb=wb/m;
  wf=wf/m;
  %variance
  for t=1:m
      if(b(t,1)<(i))
  vrb=vrb+((b(t,1)-mb)^2);
  vb=vb+1;
      else
  vrf=vrf+((b(t,1)-mf)^2);
  vf=vf+1;
      end
  end
  if(vb==0)
      vrb=0;
      vrf=vrf/vf;
  elseif(vf==0)
      vrf=0;
      vrb=vrb/vb;
  else
  vrb=vrb/vb;
  vrf=vrf/vf;
  end