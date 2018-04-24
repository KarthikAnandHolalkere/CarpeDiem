% author: Karthik Anand Holalkere 

% load the json data from foursquare search result through a file
jsonData = jsondecode(fileread('foursquare.json'));
% store the location of every result
for i=1:30
   dataL(i,1) = jsonData.response.group.results(i).venue.location.lat;
   dataL(i,2) = jsonData.response.group.results(i).venue.location.lng;
   L(i,1) = string(jsonData.response.group.results(i).venue.name);
end
% result name and corresponding location
data = horzcat(L,dataL);
% parameters for DBSCAN clustering
epsilon=0.0092;
MinPts=16;
% DBSCAN clustering
Cid=DBSCAN(dataL,epsilon,MinPts);
% name with corresponding location and cluster to which it belongs
data = horzcat(data,Cid);
% Visualization of the results
colors = hsv(max(Cid));
Cnames = {};
for i=1:max(Cid)
 dataC = dataL(Cid==i,:);
 Cnames{end+1} = ['cluster ' num2str(i)];
 if ~isempty(dataC)
     plot(dataC(:,1),dataC(:,2),'x','MarkerSize',6,'Color',colors(i,:));
 end
 hold on;
end
hold off;
legend(Cnames);
title(['FourSquareClustering (epsilon = ' num2str(epsilon) ', MinPts = ' num2str(MinPts) ')']);
 
 