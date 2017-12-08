[FV, validity, ffdP] = mirror_ffd_Express(-1*rand(1,84), 'mirrorBase.stl');
figure(1);
subplot(2,2,1);
plot(FV.vertices(1,:),FV.vertices(2,:),'x');
%hold on;
axis equal;
grid on;
%axis([700 1100 -1100 -700]);
xlabel('x');ylabel('y');

subplot(2,2,2);
plot(FV.vertices(1,:),FV.vertices(3,:),'x');
%hold on;
xlabel('x');ylabel('z');
grid on;
axis equal;
%axis([700 1100 600 800]);

subplot(2,2,3);
plot(FV.vertices(2,:),FV.vertices(3,:),'x');
%hold on;
xlabel('y');ylabel('z');
grid on;
axis equal;
%axis([-1100 -700 600 800]);

figure(2)
hold off;
plot3(FV.vertices(1,:),FV.vertices(2,:),FV.vertices(3,:),'x');
hold on;
xlabel('x');ylabel('y');zlabel('z');
grid on;
axis equal;
