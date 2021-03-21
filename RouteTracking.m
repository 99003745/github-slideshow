[latitude] = xlsread('C:\Users\kumar\Downloads\Sensor_record_20210313_182822_AndroSensor.csv','V2:V1248');
[longitude] = xlsread('C:\Users\kumar\Downloads\Sensor_record_20210313_182822_AndroSensor.csv','W2:W1248');
raw = [latitude,longitude];
data = raw;
Locationdata = table;
Locationdata.LATITUDE = data(:,1);
Locationdata.LONGITUDE = data(:,2);
lat = Locationdata{:,1};
long = Locationdata{:,2};

for i = 1:(length(lat)-1)
    lat1 = lat(i);
    long1 = long(i);
    lat2 = lat(i+1);
    long2 = long(i+1);
   
end

plot(lat,long);
plot(lat, long, '-r',lat(1),long(1),'*g',lat(end), long(end),'*b','LineWidth',3, 'MarkerSize',10);
hold on;
legend('Route','Start Point','End Point');
xlabel('Latitude');
ylabel('Longitude');
hold off

wm = webmap('Open Street Map');
for y=1:(length(lat)-1)
mwLat = lat(y);
mwLon = long(y);
mwLat1 = lat(y+1);
mwLon2 = long(y+1);

wmmarker(mwLat, mwLon)
wmmarker(mwLat1, mwLon2)
end
 


