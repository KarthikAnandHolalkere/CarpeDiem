%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPML110
% Project Title: Implementation of DBSCAN Clustering in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function [IDX]=DBSCAN(X,epsilon,MinPts)
    C=0;
    n=size(X,1);
    IDX=zeros(n,1);
    % Modified by Karthik Anand Holalkere for using the great circle
    % distance instead of eucledean distance
    for v=1:n
    for w=1:n
    D(v,w)=distance(X(v,1),X(v,2),X(w,1),X(w,2));
    end
    end
    % end of modified code
    visited=false(n,1);
    for i=1:n
        if ~visited(i)
            visited(i)=true;
            Neighbors=RegionQuery(i);
             if numel(Neighbors) ~= 0
                C=C+1;
                ExpandCluster(i,Neighbors,C);
             end   
        end
    end
    
    function ExpandCluster(i,Neighbors,C)
        IDX(i)=C;
        k = 1;
        while true
            j = Neighbors(k);
            if ~visited(j)
                visited(j)=true;
                Neighbors2=RegionQuery(j);
                if numel(Neighbors2)>=MinPts
                    Neighbors=[Neighbors Neighbors2];   %#ok
                end
            end
            if IDX(j)==0
                IDX(j)=C;
            end
            k = k + 1;
            if k > numel(Neighbors)
                break;
            end
        end
    end
    function Neighbors=RegionQuery(i)
        Neighbors=find(D(i,:)<=epsilon);
    end
end



