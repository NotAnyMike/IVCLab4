function merge(location,image)
    window_size = [100, 300];
    i=location(:,1);j=location(:,2);
    rangex = i+window_size(2)-1;
    rangey = j+window_size(1)-1;
    box_index = [j,rangey,i,rangex];

    num = size(box_index,1);
    threshould = 22; % this is from the step in sliding window. step is 15.
    dist_matrix = zeros(num,num);
    new_bbox = [];
    if num >=2 % computer the distence matrix
        img_index = box_index;
        for i = 1: num
           points = [img_index(i,1),img_index(i,3)];
           dist = pdist2(points,[img_index(:,1),img_index(:,3)]);
           dist_matrix(i,:) = dist;  
        end   
        g_i = 1;
        while(size(dist_matrix,1)~=0) % reduce the number of boudning box
            %index_neighbor = find(dist_matrix(i,:) <= threshould & dist_matrix(i,:) >0);
            index_neighbor = find(dist_matrix(g_i,:) <= threshould);
            index_self = find(dist_matrix(g_i,:) == 0);
            num_nv = size(index_neighbor,2);
            sub_nv = [];
            if  num_nv - size(index_self,2) ==0
                new_bbox = [new_bbox;box_index(g_i,:)];
                dist_matrix = removerows(dist_matrix,'ind',g_i);
                dist_matrix = removerows(dist_matrix','ind',g_i);
                dist_matrix = dist_matrix';
                box_index = removerows(box_index,'ind',g_i);
            else
                
                for ij = 1:num_nv
                    tmp_n = find(dist_matrix(ij,:) <= threshould);
                    tmp_nv= size(tmp_n,2);
                    sub_nv = [sub_nv;tmp_nv];    
                end
                [~,max_n] = max(sub_nv);
                new_bbox = [new_bbox;box_index(max_n,:)];
                
                box_index = removerows(box_index,'ind',index_neighbor);
                
                dist_matrix = removerows(dist_matrix,'ind',index_neighbor);
                dist_matrix = removerows(dist_matrix','ind',index_neighbor);
                dist_matrix = dist_matrix';
                %g_i = g_i+1;
            end 
       
        end
    end    
    draw_box(image,new_bbox);
        
       
   
        
         