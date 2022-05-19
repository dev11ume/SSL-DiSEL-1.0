% PROGRAM TO GENERATE LINEAR LANDSCAPE

function draw_linear_ssl_1(Intx,Us3,lm,sm,l,ln,ls2,ring_start,ring_stop,graph_typ)

mx= max(Intx);
mn= min(Intx);

% SELECT WHICH RINGS TO DISPLAY
if ring_start==0
    im=1;
else
    im=ring_start;
end
if ring_stop==0
    ie=lm+1;
else
    ie=ring_stop;
end

% PLOT EACH MISMATCH
for i=im:ie
    if i==1 || l(i)>=10
        
        Z2=Intx(ln(i,1):ln(i,2))';
        
        % SMOOTHEN THE INTENSITY
        Zs2=smooth(Z2,round((l(i)*sm/100)+1.5));
        
        f=figure('Name',['SSL/DiSEL Mismatch:' num2str(i-1)],...
            'NumberTitle','off');
        hold on;
        set(f,'Renderer','zbuffer');
        
        % CHOOSE HORIZONTAL OR VERTICAL BAR PLOT
        if (graph_typ==1)
            h=bar(Zs2,1);
        else
            h=barh(Zs2,1);
        end
        
%         % COLORING THE BARS
%         ch = get(h,'Children');
%         fvd = get(ch,'Faces');
%         fvcd = get(ch,'FaceVertexCData');
%         shading interp;
%         for ixx = 1:l(i)
%             % IF INTENSITY <=0 - COLOR AS GRAY
%             if Zs2(ixx)>0
%                 fvcd(fvd(ixx,1)) = 0;
%                 fvcd(fvd(ixx,4)) = 0;
%                 fvcd(fvd(ixx,2)) = Zs2(ixx);
%                 fvcd(fvd(ixx,3)) = Zs2(ixx);
%             else
%                 fvcd(fvd(ixx,1)) = Zs2(ixx);
%                 fvcd(fvd(ixx,4)) = Zs2(ixx);
%                 fvcd(fvd(ixx,2)) = Zs2(ixx);
%                 fvcd(fvd(ixx,3)) = Zs2(ixx);
%             end
%             set(ch,'FaceVertexCData', fvcd);
%         end
        caxis([mn mx]);
        
        % CHANGE IN COLORMAP TO ASSIGN MAX TO 1
%         colormp2(1);
        
        if graph_typ==1
            axis([ 0 l(i) mn mx]);
            set(gca,'XTickLabel','');
        else
            axis([ mn mx 0 l(i)]);
            set(gca,'YTick',0:l(i)/20:l(i));
            set(gca,'YTickLabel',char(Us3(ln(i,1):ln(i,2),lm:ls2-lm+1)));
        end
        
        hold off;
    end
end
