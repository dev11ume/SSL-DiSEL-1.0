% PROGRAM TO DRAW DIFFERENCE LANDSCAPE

function varargout=disel_1(inp,inp2,motif,varargin)

try
    if (nargin-length(varargin)) ~= 3 || rem(length(varargin),2)~=0
        error('Wrong number of required inputs');
    end
catch ME
    if from_gui~=0
        delete(from_gui);
        delete(h_msgbox);
    end
    disp('Error occurred');
    errordlg(ME.message);
end
varargout=sslc_1(inp,motif,inp2,varargin{:});
end

