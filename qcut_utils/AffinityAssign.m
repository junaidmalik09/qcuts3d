function H=AffinityAssign(neighbourhood,length_final_neighbours,ALL_DIST, max_label,centroid_dist,repetitions)

%Initialize Hamiltonian
H=zeros(max_label,max_label);

%first_neighbourhood=neighbourhood.First;
%second_neighbourhood=neighbourhood.Second;
%third_neighbourhood=neighbourhood.Third;
%fourth_neighbourhood=neighbourhood.Fourth;
%fifth_neighbourhood=neighbourhood.Fifth;

%length_first_neighbours=cellfun('length',first_neighbourhood);
%length_second_neighbours=cellfun('length',second_neighbourhood);
%length_third_neighbours=cellfun('length',third_neighbourhood);
%length_fourth_neighbours=cellfun('length',fourth_neighbourhood);
%length_fifth_neighbours=cellfun('length',fifth_neighbourhood);

% calculate degree matrix

%W = zeros(size(ALL_DIST));
%for i=1:max_label
%    neighbours = neighbourhood{i};
%    for j=1:length(neighbours)
%        W(i,neighbours(j)) = ALL_DIST(i,neighbours(j));
%    end
%end
W = ALL_DIST;
degs = sum(W, 2);
D    = sparse(1:size(W, 1), 1:size(W, 2), degs);


% compute unnormalized Laplacian
L = D - W;
%keyboard
% for i=1:max_label
%    self_affinity = 0;
%    for j=1:max_label
%        if (1)
%            dist=ALL_DIST(i,j);
%            %mean_norm=lengths(i,j);
%            UPDATE=dist;%./(mean_norm+eps);
%            H(i,j)=-UPDATE;
%            self_affinity=self_affinity+UPDATE;
%        %else
%            %disp([num2str(i) ',' num2str(j)]);
%        end
%    end
%    H(i,i) = self_affinity;
% end

%keyboard
%for label_counter=1:max_label
    
    % FIRST NEIGHBOURS
%     neighbours=(first_neighbourhood{label_counter});
%     length_neighbours=length_first_neighbours(label_counter);
%     for neighbour_counter=1:length(neighbours)
%         dist=ALL_DIST(label_counter,neighbours(neighbour_counter));
%         repetition=repetitions(label_counter,neighbours(neighbour_counter));
%         mean_norm=repetition;%(length_neighbours*length_final_neighbours(neighbours(neighbour_counter))).^2+(length_first_neighbours(neighbours(neighbour_counter))*length_final_neighbours(label_counter)).^2;
%         UPDATE=dist/(mean_norm+eps);
%         H(label_counter,neighbours(neighbour_counter))=-UPDATE;
%         H(label_counter,label_counter)=H(label_counter,label_counter)+UPDATE;
%     end
    
    
    % SECOND NEIGHBOURS
%     neighbours=(second_neighbourhood{label_counter});
%     length_neighbours=length_second_neighbours(label_counter);
%     for neighbour_counter=1:length(neighbours)
%         dist=ALL_DIST(label_counter,neighbours(neighbour_counter));
%         repetition=repetitions(label_counter,neighbours(neighbour_counter));
%         mean_norm=repetition;%(length_neighbours*length_final_neighbours(neighbours(neighbour_counter))).^2+(length_second_neighbours(neighbours(neighbour_counter))*length_final_neighbours(label_counter)).^2;
%         UPDATE=(dist/(mean_norm+eps));
%         H(label_counter,neighbours(neighbour_counter))=-UPDATE;
%         H(label_counter,label_counter)=H(label_counter,label_counter)+UPDATE;
%     end
    
    % THIRD NEIGHBOURS
%     neighbours=(third_neighbourhood{label_counter});
%     length_neighbours=length_third_neighbours(label_counter);
%     for neighbour_counter=1:length(neighbours)
%         dist=ALL_DIST(label_counter,neighbours(neighbour_counter));
%         repetition=getSupervoxelAffinity(suppixel,label_counter,neighbours(neighbour_counter));
%         mean_norm=repetition;%(length_neighbours*length_final_neighbours(neighbours(neighbour_counter))).^2+(length_third_neighbours(neighbours(neighbour_counter))*length_final_neighbours(label_counter)).^2;
%         UPDATE=dist/(mean_norm);
%         H(label_counter,neighbours(neighbour_counter))=-UPDATE;
%         H(label_counter,label_counter)=H(label_counter,label_counter)+UPDATE;
%     end
%     
%     % FOURTH NEIGHBOURS
%     neighbours=(fourth_neighbourhood{label_counter});
%     length_neighbours=length_fourth_neighbours(label_counter);
%     for neighbour_counter=1:length(neighbours)
%         dist=ALL_DIST(label_counter,neighbours(neighbour_counter));
%         repetition=getSupervoxelAffinity(suppixel,label_counter,neighbours(neighbour_counter));
%         mean_norm=repetition;%(length_neighbours*length_final_neighbours(neighbours(neighbour_counter))).^2+(length_fourth_neighbours(neighbours(neighbour_counter))*length_final_neighbours(label_counter)).^2;
%         UPDATE=dist/(mean_norm);
%         H(label_counter,neighbours(neighbour_counter))=-UPDATE;
%         H(label_counter,label_counter)=H(label_counter,label_counter)+UPDATE;
%     end
%     
%     % FIFTH NEIGHBOURS
%     neighbours=(fifth_neighbourhood{label_counter});
%     length_neighbours=length_fifth_neighbours(label_counter);
%     for neighbour_counter=1:length(neighbours)
%         dist=ALL_DIST(label_counter,neighbours(neighbour_counter));
%         repetition=getSupervoxelAffinity(suppixel,label_counter,neighbours(neighbour_counter));
%         mean_norm=repetition;%(length_neighbours*length_final_neighbours(neighbours(neighbour_counter))).^2+(length_fifth_neighbours(neighbours(neighbour_counter))*length_final_neighbours(label_counter)).^2;
%         UPDATE=dist/(mean_norm);
%         H(label_counter,neighbours(neighbour_counter))=-UPDATE;
%         H(label_counter,label_counter)=H(label_counter,label_counter)+UPDATE;
%     end
    
    
%end

H=L;
%H = H/mean(H(:));
%/max(L(:));
%H=-L/(min(L(:)));
%H=mat2gray(H);