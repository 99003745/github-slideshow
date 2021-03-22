[latitude1] = xlsread('C:\Users\99003745\Documents\Sensor_record_20210313_182822_AndroSensor.csv','V2:V1248');
[longitude1] = xlsread('C:\Users\99003745\Documents\Sensor_record_20210313_182822_AndroSensor.csv','W2:W1248');
[raw0_0] = xlsread('C:\Users\99003745\Documents\Sensor_record_20210313_182822_AndroSensor.csv','V2:W1239');
[raw0_1] = xlsread('C:\Users\99003745\Documents\Sensor_record_20210313_182822_AndroSensor.csv','Z2:Z1239');
[raw0_2] = xlsread('C:\Users\99003745\Documents\Sensor_record_20210313_182822_AndroSensor.csv','AD2:AD1239');
[raw0_3] = xlsread('C:\Users\99003745\Documents\Sensorrecord.csv','U2:U3000');
[raw0_4] = xlsread('C:\Users\99003745\Documents\Sensorrecord.csv','AD2:AD3000');
[raw0_5] = xlsread('C:\Users\99003745\Documents\Sensorrecord.csv','C2:C32000');
[raw0_6] = xlsread('C:\Users\99003745\Documents\Sensorrecord.csv','AD2:AD32000');
rawtracing = [raw0_0,raw0_1,raw0_2];


%% Create output variable
data = rawtracing;

%% Create table
displacementdata = table;

%% Allocate imported array to column variable names
displacementdata.LATITUDE = data(:,1);
displacementdata.LONGITUDE = data(:,2);
displacementdata.SPEED = data(:,3);
displacementdata.Timesincestartinms = data(:,4);


%% Clear temporary variables
% For Crowd Detection By 99003783
raw8 = [raw0_3,raw0_4];
data = raw8;
stepdata1 = table;

stepdata1.SOUNDLEVEL  = data(:,1);
stepdata1.Timesincestartinms  = data(:,2);

s = stepdata1.SOUNDLEVEL;
t=stepdata1.Timesincestartinms;

sum=0;
for i = 1:2999
    if(s(i)<38)
        sum=sum+1;
        if(sum==500)
        disp("area is peace: " + t(i));
        sum=0;
        end
        
    elseif(s(i)>38 && s(i)<48)
             sum=sum+1;
        if(sum==500)
            disp("area is less peace: " + t(i));
        sum=0;
        end
  elseif(s(i)>49 && s(i)< 61)
        
        sum=sum+1;
        if(sum==500)
        disp("area is medium crowd: " + t(i));
        sum=0;
        end
   elseif (s(i)> 62 && s(i)<79)
        sum=sum+1;
        if(sum==500)
            disp("area is very crowd: " + t(i));
            sum=0;
        end
    end
end

%FOR DISPLACEMENT
clearvars data raw raw0_0 raw0_1 R;
latitude = displacementdata.LATITUDE;
longitude = displacementdata.LONGITUDE;
speed = displacementdata.SPEED;
time = displacementdata.Timesincestartinms;
% Calculate Distance
Radius_of_earth = 637*exp(3);
initial_latitude = latitude(1)*pi/180;
final_latitude = latitude(1238)*pi/180;
initial_longitude = longitude(1)*pi/180;
final_longitude = longitude(1238)*pi/180;
latitude_difference = abs(initial_latitude-final_latitude);
longitude_difference = abs(initial_longitude-final_longitude);
% Calculate Displacement
Harversine_const_a = sin(latitude_difference/2)*sin(latitude_difference/2) + cos(initial_latitude)*cos(final_latitude)*sin(longitude_difference/2)*sin(longitude_difference/2);
Harversine_const_c = 2*atan2(sqrt(Harversine_const_a),sqrt(1-Harversine_const_a));
total_displacement = Radius_of_earth*Harversine_const_c;
% Calculate Speed
average_speed = mean(speed);
% Calculate velocity

total_time = time(1238)/(3.6*(10^6));
average_velocity = total_displacement/total_time;
total_distance = total_time*average_speed;
disp("The Total Distance You travelled was " + total_distance+"km");
disp("And your average speed was " + average_speed+"kmph");
disp("BUT");
disp("You Came only "+ total_displacement+"km from origin");
disp("And your velocity was just "+average_velocity+"kmph");





%For Fidget Sensing
raw4 = [raw0_5,raw0_6];
data = raw4;
stepdata1 = table;
stepdata1.ACCELEROMETERZ = data(:,1);
stepdata1.Timesincestartinms  = data(:,2);
sum=0;

Z_axis=stepdata1.ACCELEROMETERZ;
time=stepdata1.Timesincestartinms; 
for i =1:31999
    if Z_axis(i)>6
        sum=sum+1;
    end
end

Number_fidget_sec=sum/201;
Number_fidget_min=Number_fidget_sec/60;
disp("You Fidgeted for: " + Number_fidget_sec + " sec")
disp(Number_fidget_min);

disp("Out of: " + time(31999)+ " sec")

% print("out of: " + time(31999))
%subplot(2,1,1)
%plot(Z_axis,time)
%subplot(2,1,2)
%stem(y,x)

% For tracing the path coverage By PS 99003745
rawtracing = [latitude1,longitude1];

data = rawtracing;
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
title(sprintf('Plot of the route covered') );
hold off

wm = webmap('Open Street Map');


for y=1:(length(lat)-1)
    
mwLat = lat(y+10);
mwLon = long(y+10);
x=y+400;
mwLat1 = lat(x);
mwLon2 = long(x);

     
%wmmarker(mwLat, mwLon);
wmmarker(mwLat1, mwLon2);
 
end
