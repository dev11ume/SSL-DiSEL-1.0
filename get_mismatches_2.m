% FUNCTION TO GET MISMATCHES AND ARRANGEMENT FOR THE MOTIF SEQUENCE

function  [Int_indx,Ucode1,Us1,Us1r,l,ln]=get_mismatches_2(n,mism,pos_mis_mot,match_to_mot,mot_fr,F,R,ls2,lm,motif,sel)

aa=[1 0 2 0 0 0 3 0 0 0 0 0 0 0 0 0 0 0 0 4 0 0 5 5 0 0]; % CONVERSION FROM NUCLEOTIDE TO 5 BASE (5 IS NOT USED)

l=zeros(lm+1,1); % NUMBER OF SEQUENCES IN EACH RING
ln=zeros(lm+1,2);% START AND STOP OF SEQUENCES IN THE SORTED LIST FOR EACH RING

Us1=zeros(n,ls2);% KEEPS TRACH OF THE SEQUENCE
Us1r=zeros(n,ls2);% KEEPS TRACH OF THE SEQUENCE
Ucode1=zeros(n,lm+2+ls2+lm+1); % ALL THE SEQUENCE INFORMATION IS STORED IN IT

%TEMPORARY
mismatch=zeros(ls2-lm+1,1); % KEEPS TRACK OF THE TOTAL MISMATCHES wrt DIFFERENT STARTING POSITIONS
indxes=zeros(ls2-lm+1,1); % INDEX AFTER CONVERTING THE SEQUENCE FROM NUCLEOTIDE TO NUMBER BY BASE 5 CONVERSION
fivesi = power(5,0:lm-2);

indx_all=aa(F-64)-1; % CONVERTING THE NUCLEOTIDE SEQ TO NUMBER ACGT TO 1234

for i=1:n
    indx=indx_all(i,:);
    
    % FINDING indxes & mismatch 
    indn=indx(ls2-lm+2:ls2)*fivesi';
    for ind=ls2-lm+1:-1:1
        indn=5*indn+indx(ind);
        indxes(ind)=indn+1;
        mismatch(ind)=mism(indn+1);
        indn=rem(indn,5^(lm-1));
    end
    
    [k, pos]=min(mismatch); % FINDING MINIMUM MISMATCH
    
    % TO WHICH MOTIF IT MATCHED AND FOR FORWARD OR REVERSE
    mt=match_to_mot(indxes(pos));
    p2=pos_mis_mot(indxes(pos),:);
    l(k+1)=l(k+1)+1;
    if mot_fr(indxes(pos))==1
        Us1(i,:)=F(i,:);
        Us1r(i,:)=R(i,:);
    else
        Us1(i,:)=R(i,:);
        Us1r(i,:)=F(i,:);
        pos=ls2-lm+2-pos;
    end
    
    % GENERATING Ucode
    XX=char('X'*ones(1,lm));
    YY=Us1(i,pos:lm+pos-1);
    XX(p2==1)=YY(p2==1);
    
    % DIFFERENT ARRANGEMENTS FOR SEQUENCES IN A RING
switch sel
    case 1
        Ucode1(i,:)=[k p2(lm:-1:1) XX Us1(i,lm+pos:ls2) 'X' Us1(i,pos-1:-1:1) motif(mt,:) pos];  
    case 2
        Ucode1(i,:)=[k p2(lm:-1:1) XX Us1(i,pos-1:-1:1) 'X' Us1(i,lm+pos:ls2) motif(mt,:) pos];
    case 3
        Ucode1(i,:)=[k p2(lm:-1:1) Us1(i,lm+pos:ls2) 'X' Us1(i,pos-1:-1:1) XX motif(mt,:) pos];
    case 4
        Ucode1(i,:)=[k p2(lm:-1:1) Us1(i,pos-1:-1:1) 'X' Us1(i,lm+pos:ls2) XX motif(mt,:) pos];
    case 5
        Ucode1(i,:)=[k p2(lm:-1:1) XX pos Us1(i,lm+pos:ls2) 'X' Us1(i,pos-1:-1:1) motif(mt,:)];  
    case 6
        Ucode1(i,:)=[k p2(lm:-1:1) XX pos Us1(i,pos-1:-1:1) 'X' Us1(i,lm+pos:ls2) motif(mt,:)];
    case 7
        Ucode1(i,:)=[k p2(lm:-1:1) pos Us1(i,lm+pos:ls2) 'X' Us1(i,pos-1:-1:1) XX motif(mt,:)];
    case 8
        Ucode1(i,:)=[k p2(lm:-1:1) pos Us1(i,pos-1:-1:1) 'X' Us1(i,lm+pos:ls2) XX motif(mt,:)];
    case 9
        Ucode1(i,:)=[k motif(mt,:) p2(lm:-1:1) XX Us1(i,lm+pos:ls2) 'X' Us1(i,pos-1:-1:1) pos];  
    case 10
        Ucode1(i,:)=[k motif(mt,:) p2(lm:-1:1) XX Us1(i,pos-1:-1:1) 'X' Us1(i,lm+pos:ls2) pos];
    case 11
        Ucode1(i,:)=[k motif(mt,:) p2(lm:-1:1) Us1(i,lm+pos:ls2) 'X' Us1(i,pos-1:-1:1) XX pos];
    case 12
        Ucode1(i,:)=[k motif(mt,:) p2(lm:-1:1) Us1(i,pos-1:-1:1) 'X' Us1(i,lm+pos:ls2) XX pos];
    case 13
        Ucode1(i,:)=[k motif(mt,:) p2(lm:-1:1) XX pos Us1(i,lm+pos:ls2) 'X' Us1(i,pos-1:-1:1)];  
    case 14
        Ucode1(i,:)=[k motif(mt,:) p2(lm:-1:1) XX pos Us1(i,pos-1:-1:1) 'X' Us1(i,lm+pos:ls2)];
    case 15
        Ucode1(i,:)=[k motif(mt,:) p2(lm:-1:1) pos Us1(i,lm+pos:ls2) 'X' Us1(i,pos-1:-1:1) XX];
    case 16
        Ucode1(i,:)=[k motif(mt,:) p2(lm:-1:1) pos Us1(i,pos-1:-1:1) 'X' Us1(i,lm+pos:ls2) XX];
    otherwise
        error('Incorrect sel input should be between 1-8');
end

end

%FINDING NUMBER OF SEQUENCES IN EACH RING
ln(1,1)=1;
ln(1,2)=l(1);
for i=2:lm+1
 ln(i,1)=ln(i-1,2)+1;
 ln(i,2)=ln(i,1)+l(i)-1;
end

[Ucode1,Int_indx]=sortrows(Ucode1);% Ucode1 is PASSED TO REMEMBER MISMATCH
Us1=Us1(Int_indx,:);
Us1r=Us1r(Int_indx,:);
% Ucode1=Ucode1(:,1);


