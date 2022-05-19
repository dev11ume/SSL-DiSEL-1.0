% FUNCTION TO READ INPUT FILE
function  [F,R,Int,ls,n]=read_csi_file(inp,colum)

if ~exist(inp,'file')
    error('File not found');
end

xx='[F,R,Int]=textread(inp,''%s %s';
for i=2:colum
    xx=[xx ' %*s'];
end
xx=[xx ' %s'];
xx=[xx '%*[^\n]'];
xx=[xx ' '',1); '];
eval(xx);

if isempty(str2num(char(Int(1)))) % IF THERE IS A HEADER LINE
    xx='[F,R,Int]=textread(inp,''%s %s';
    for i=2:colum
        xx=[xx ' %*s'];
    end
    xx=[xx ' %f'];
    xx=[xx '%*[^\n]'];
    xx=[xx ' '',''headerlines'',1); '];
    eval(xx);
else   % IF THERE IS NO HEADER LINE
    xx='[F,R,Int]=textread(inp,''%s %s';
    for i=2:colum
        xx=[xx ' %*s'];
    end
    xx=[xx ' %f'];
    xx=[xx '%*[^\n]'];
    xx=[xx ' ''); '];
    eval(xx);
end

F=upper(char(F));
R=upper(char(R));

n=size(F,1);
ls=size(F,2);
ls2=size(R,2);

if ls~=ls2 || ~isempty(find(R==' ',1)) || ~isempty(find(F==' ',1)) % IF LENGTH OF FORWARD AND REVERSE SEQUENCE NOT EQUAL
    error('Error in the format of input file','Bad Input File','modal');
end

end