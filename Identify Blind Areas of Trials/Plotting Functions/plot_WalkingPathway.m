% Function for plotting walking pathway in 3D
% part of the the Blind_Areas_Gait_Trials demos (started at v5)

function plot_WalkingPathway(X_1,X_2,Y_1,Y_2,Z_1,Z_2,x_pathway,y_pathway,z_pathway,x_limits,y_limits,z_limits,...
                             y_offset,path_length,path_width)

hold on
surf(X_1,Y_1,z_pathway(1)*ones(size(X_1)),'facecolor',[0 0 0],'facealpha',0.2);
surf(X_1,Y_1,z_pathway(2)*ones(size(X_1)),'facecolor',[0 0 0],'facealpha',0.2);
surf(x_pathway(1)*ones(size(Y_2)),Y_2,Z_1,'facecolor',[0 0 0],'facealpha',0.2);
surf(x_pathway(2)*ones(size(Y_2)),Y_2,Z_1,'facecolor',[0 0 0],'facealpha',0.2);
surf(X_2,y_pathway(1)*ones(size(X_2)),Z_2,'facecolor',[0 0 0],'facealpha',0.2);
surf(X_2,y_pathway(1)*ones(size(X_2)),Z_2,'facecolor',[0 0 0],'facealpha',0.2);

axis equal
grid on; grid minor;
xlabel('x-axis (m)'); ylabel('y-axis (m)'); zlabel('z-axis (m)')
axis([x_limits(1) x_limits(2) y_limits(1) y_limits(2) z_limits(1) z_limits(2)]);

% Plot center line of pathway along floor
line([0,0],[y_offset,y_offset+path_length],[0,0],'LineStyle','--','Color',[0.4660 0.6740 0.1880],'Linewidth',1.2)

% Plot pathway marks along floor
plot3( [-path_width/2 -path_width/2 path_width/2 path_width/2 -path_width/2], [y_offset y_offset+path_length y_offset+path_length y_offset y_offset],...
       [0 0 0 0 0],'Color',[0.4660 0.6740 0.1880],'Linewidth',1.2 )

end