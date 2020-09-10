function H=UpdateDiagonal(GVMean,bkg,H,boundaries,v,superposed)
if nargin==6
    %keyboard
    for bnd_cnt=1:length(boundaries)
        H(boundaries(bnd_cnt),boundaries(bnd_cnt))=H(boundaries(bnd_cnt),boundaries(bnd_cnt))+((1-superposed(bnd_cnt)));
    end
else
    
    for bnd_cnt=1:length(boundaries)
        H(boundaries(bnd_cnt),boundaries(bnd_cnt))=H(boundaries(bnd_cnt),boundaries(bnd_cnt))+(v(bnd_cnt));
    end
end