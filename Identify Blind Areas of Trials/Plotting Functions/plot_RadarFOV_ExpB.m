% Function for plotting radar field-of-view (FOV) in 3D
% for experiment C

function plot_RadarFOV_ExpB(radar_1_pos_3d,radar_2_pos_3d,theta,phi,max_range,beam_angle,z_limits)

eps=0.2;%thickness of top plane (at z=zmax) and bottom plane (at z=0)

for radar_ind = [1,2]
    if radar_ind==1
        radar_pos = radar_1_pos_3d;
        col = [0 0 1]; %Blue color
        theta0=-theta; % Anticlock-wise angle
        phi0 = -phi;
    elseif radar_ind==2
        radar_pos = radar_2_pos_3d;
        col = [1 0 0]; %Red color
        theta0=-theta + 180; % Anticlock-wise angle
        phi0 = phi;
    end

    % Plot radar
    plot3(radar_pos(1),radar_pos(2),radar_pos(3),'Color',col,'Marker','.','Markersize',24)
    line([radar_pos(1) radar_pos(1)],[radar_pos(2) radar_pos(2)], [0 radar_pos(3)],'LineStyle','--','Color',col)
        
    % Line-of-Sight (center line) of radar
    center_line=line([radar_pos(1),radar_pos(1)],[radar_pos(2),radar_pos(2)+max_range],...
                     [radar_pos(3),radar_pos(3)],'LineStyle','--','Color',col,'Linewidth',1.5);
    rotate(center_line, [0 0 1], theta0,[radar_pos(1) radar_pos(2) radar_pos(3)]) % Anticlock-wise rotation by angle theta
    rotate(center_line, [1 0 0], phi0, [radar_pos(1) radar_pos(2) radar_pos(3)])  % Anticlock-wise rotation by angle phi
    
    % Generate spherical sector corresponding to the radar's field-of-view.
    for R=sqrt(linspace(eps.^2,max_range.^2,50))%generate contours along the top and bottom plane for R~=max_range or generate the whole thing for R=max_range, span with square to make it equally dense for all radii
        %generate shape
        h=[linspace(0,R*cosd(beam_angle/2),100) linspace(R*cosd(beam_angle/2),R,100)];
        th=linspace(0,2*pi,500);
        [h,th]=meshgrid(h,th);
        r=h*tand(beam_angle/2);
        r(h>R*cosd(beam_angle/2))=sqrt(R^2-h(h>R*cosd(beam_angle/2)).^2);
        X=r.*cos(th);
        Z=r.*sin(th);
        Y=h;
        %
        if R==max_range
            p0=surf(X+radar_pos(1),Y+radar_pos(2),Z+radar_pos(3),'edgecolor','none','facecolor',col,'facealpha',0.2);
            rotate(p0, [0 0 1],theta0,[radar_pos(1) radar_pos(2) radar_pos(3)])% Anticlockwise rotation by theta0
            rotate(p0, [1 0 0],phi0,[radar_pos(1) radar_pos(2) radar_pos(3)])% Anticlockwise rotation by -phi
            Z0=p0.ZData;
            Z0(Z0<z_limits(1))=NaN; % Anything below z_limits(1) is set to NaN
            Z0(Z0>z_limits(2))=NaN; % Anything above z_limits(2) is set to NaN
            p0.ZData=Z0;
        else
            p0bot=surf(X+radar_pos(1),Y+radar_pos(2),Z+radar_pos(3),'edgecolor','none','facecolor',col,'facealpha',0.2);
            rotate(p0bot, [0 0 1],theta0,[radar_pos(1) radar_pos(2) radar_pos(3)])%rotation theta
            rotate(p0bot, [1 0 0],phi0,[radar_pos(1) radar_pos(2) radar_pos(3)])%rotation phi
            Z0=p0bot.ZData;
            Z0(Z0<z_limits(1))=NaN; % Anything below z_limits(1) is set to NaN 
            Z0(Z0>z_limits(2))=NaN; % Anything above z_limits(2) is set to NaN
            Z0((Z0>(z_limits(1)+eps))&(Z0<(z_limits(2)-eps)))=NaN;
            p0bot.ZData=Z0;
        end
    end
end
end