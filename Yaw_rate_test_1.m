clear
a = arduino('COM4', 'Uno', 'Libraries', {'I2C'});
Lz = 0.215; %cm
addrs = scanI2CBus(a);
mpu1 = device(a,'I2CAddress',0x68);
mpu2 = device(a,'I2CAddress',0x69);
writeRegister(mpu1, 0x6B,0b00000000);
writeRegister(mpu1, 0x1B,0x00000000);
writeRegister(mpu1, 0x1C,0b00000000);
dur = 100;
gForceX1 = zeros(1,dur);
gForceY1 = zeros(1,dur);
gForceZ1 = zeros(1,dur);

gyroX1 = zeros(1,dur);
gyroY1 = zeros(1,dur);
gyroZ1 = zeros(1,dur);


gForceX2 = zeros(1,dur);
gForceY2 = zeros(1,dur);
gForceZ2 = zeros(1,dur);

gyroX2 = zeros(1,dur);
gyroY2 = zeros(1,dur);
gyroZ2 = zeros(1,dur);

disp("Start Rotatng");
for i = 1:dur
fprintf("%d iterations to go \n",dur - i);
write(mpu1, 0x3B,'uint8');
data1 = read(mpu1, 6,'uint8');
gForceZ1(i) = (double(bitshift(int16(data1(5)), 8)) + data1(6));
gForceZ1(i) = gForceZ1(i) / 16384.0;
gForceY1(i) = (double(bitshift(int16(data1(3)), 8)) + data1(4));
gForceY1(i) = gForceY1(i) / 16384.0;
gForceX1(i) = (double(bitshift(int16(data1(1)), 8)) + data1(2));
gForceX1(i) = gForceX1(i) / 16384.0;

write(mpu1, 0x43,'uint8');
datagyro = read(mpu1, 6,'uint8');
gyroZ1(i) = (double(bitshift(int16(datagyro(5)), 8)) + datagyro(6));
gyroZ1(i) = gyroZ1(i) / 131.0;
gyroY1(i) = (double(bitshift(int16(datagyro(3)), 8)) + datagyro(4));
gyroY1(i) = gyroY1(i) / 131.0;
gyroX1(i) = (double(bitshift(int16(datagyro(1)), 8)) + datagyro(2));
gyroX1(i) = gyroX1(i) / 131.0;


write(mpu2, 0x3B,'uint8');
data2 = read(mpu2, 6,'uint8');
gForceZ2(i) = (double(bitshift(int16(data2(5)), 8)) + data2(6));
gForceZ2(i) = gForceZ2(i) / 16384.0;
gForceY2(i) = (double(bitshift(int16(data2(3)), 8)) + data2(4));
gForceY2(i) = gForceY2(i) / 16384.0;
gForceX2(i) = (double(bitshift(int16(data2(1)), 8)) + data2(2));
gForceX2(i) = gForceX2(i) / 16384.0;

write(mpu2, 0x43,'uint8');
datagyro2 = read(mpu2, 6,'uint8');
gyroZ2(i) = (double(bitshift(int16(datagyro2(5)), 8)) + datagyro2(6));
gyroZ2(i) = gyroZ2(i) / 131.0;
gyroY2(i) = (double(bitshift(int16(datagyro2(3)), 8)) + datagyro2(4));
gyroY2(i) = gyroY2(i) / 131.0;
gyroX2(i) = (double(bitshift(int16(datagyro2(1)), 8)) + datagyro2(2));
gyroX2(i) = gyroX2(i) / 131.0;

end