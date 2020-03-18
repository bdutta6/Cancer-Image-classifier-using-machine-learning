function [I_seg] = unsupervisedSegmentation_single(I, alpha, k)
%%
[~, ~, s] = size(I);
pix_pool = reshape(I, [], s);

tic
disp('Start kmeans');
[idx c] = kmeans(pix_pool, k, 'distance', 'sqEuclidean', 'EmptyAction', 'drop', 'maxiter', 100);
c=c(find(isfinite(c(:,1))),:);
k=size(c,1);
k_max=k;
[~, idx_tmp]=sort(c(:,1));
c=c(idx_tmp, :); %use the column indices from sort() to sort all rows of c.
c
toc

% kernel graph optimization for each image
tic
disp('Start graph optimization');
im = I;
sz = size(im);
Hc=ones(sz(1:2));
Vc=Hc;
i_ground = 0; % rank of the bakground for plotting, 0: the darkest;
%k-1 the brightest; 99: nowhere

diff=10000;
an_energy=999999999;
iter=0;
iter_v=0;
energy_global_min=99999999;
Dc = zeros([sz(1:2) k],'single');
while iter < 5
    iter=iter+1;
    clear Dc
    clear K
    c;
    for ci=1:k
        K=kernel_RBF(im,c(ci,:));
        Dc(:,:,ci)=1-K;
    end
    clear Sc
    clear K
    %% The smoothness term
    Sc = alpha*(ones(k) - eye(k));
    gch = GraphCut('open', Dc, Sc, Vc, Hc);
    [gch L] = GraphCut('swap',gch);
    [gch se de] = GraphCut('energy', gch);
    nv_energy=se+de;
    gch = GraphCut('close', gch);
    
    if (nv_energy<=energy_global_min)
        diff=abs(energy_global_min-nv_energy)/energy_global_min;
        energy_global_min=nv_energy;
        L_global_min=L;
        k_max=k;
        
        nv_energy;
        iter_v=0;
        % Calculate region Pl of label l
        if size(im, 3)==3 % Color image
            for l=0:k-1
                Pl=find(L==l);
                card=length(Pl);
                K1=kernel_RBF(im(Pl),c(l+1,1));K2=kernel_RBF(im(Pl),c(l+1,2));K3=kernel_RBF(im(Pl),c(l+1,3));
                smKI(1)=sum(im(Pl).*K1); smKI(2)=sum(im(Pl+prod(sz(1:2))).*K2); smKI(3)=sum(im(Pl+2*prod(sz(1:2))).*K3);
                smK1=sum(K1);smK2=sum(K2);smK3=sum(K3);
                if (card~=0)
                    c(l+1,1)=smKI(1)/smK1;c(l+1,2)=smKI(2)/smK2;c(l+1,3)=smKI(3)/smK3;
                else
                    c(l+1,1)=999999999;c(l+1,2)=999999999;c(l+1,3)=999999999;
                end
            end
        end
        
        if size(im, 1)==1 % Gray-level image
            for l=0:k-1
                Pl=find(L==l);
                card=length(Pl);
                K=kernel_RBF(im(Pl),c(l+1,1));
                smKI=sum(im(Pl).*K);
                smK=sum(K);
                if (card~=0)
                    c(l+1,1)=smKI/smK;
                else
                    c(l+1,1)=999999999;
                end
            end
        end
        
        
        c=c(find(c(:,1)~=999999999),:);
        c_global_min=c;
        k_global=length(c(:,1));
        k=k_global;
        
    else
        iter_v=iter_v+1;
        %---------------------------------
        %       Begin updating labels
        %---------------------------------
        % Calculate region Pl of label l
        if size(im, 3)==3 % Color image
            for l=0:k-1
                Pl=find(L==l);
                card=length(Pl);
                K1=kernel_RBF(im(Pl),c(l+1,1));K2=kernel_RBF(im(Pl),c(l+1,2));K3=kernel_RBF(im(Pl),c(l+1,3));
                smKI(1)=sum(im(Pl).*K1); smKI(2)=sum(im(Pl+prod(sz(1:2))).*K2); smKI(3)=sum(im(Pl+2*prod(sz(1:2))).*K3);
                smK1=sum(K1);smK2=sum(K2);smK3=sum(K3);
                % Calculate contour Cl of region Pl
                if (card~=0)
                    c(l+1,1)=smKI(1)/smK1;c(l+1,2)=smKI(2)/smK2;c(l+1,3)=smKI(3)/smK3;
                else
                    c(l+1,1)=999999999;c(l+1,2)=999999999;c(l+1,3)=999999999;
                    area(l+1)=999999999;
                end
            end
        end
        
        if size(im, 3)== 1 % Gray-level image
            for l=0:k-1
                Pl=find(L==l);
                card=length(Pl);
                K=kernel_RBF(im(Pl),c(l+1,1));
                smKI=sum(im(Pl).*K);
                smK=sum(K);
                % Calculate contour Cl of region Pl
                if (card~=0)
                    c(l+1,1)=smKI/smK;
                else
                    c(l+1,1)=999999999;
                    area(l+1)=999999999;
                end
            end
        end
        
        c=c(find(c(:,1)~=999999999),:);
        k=length(c(:,1));
    end
end

L=L_global_min;
energy_global_min;
c=c_global_min;

size(c,1)
iter;

%Show the results
img=zeros(sz(1),sz(2));
j=1;
%
%         figure;
%         subplot(1,3,1);
%         imagesc(im_input); axis off; hold on;
%
%         subplot(1,3,2);
%         imagesc(im); axis off; hold on; colormap gray;

for i=0:k_max-1
    LL=(L_global_min==i);
    is_zero=sum(sum(LL));
    if is_zero
        %                 img(:,:,1)=img(:,:,1)+LL*c(j,1);
        switch i
            case 0
                label_val = 0;
            case 1
                label_val = 128;
            case 2
                label_val = 255;
        end
        img(:,:,1)=img(:,:,1)+LL*label_val;
        j=j+1;
    end
%     if i~=i_ground
%         color=[rand rand rand];
%         contour(LL,[1 1],'LineWidth',2.5,'Color',color); hold on;
%     end
end
%         subplot(1,3,3);
%         imagesc(img); axis off;

%
I_seg = img;