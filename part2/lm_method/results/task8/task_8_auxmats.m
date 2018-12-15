A_val=reshape(A(:,iA(:,1)),[32,1]);

E1=zeros(32,16);
E_help=repmat(2*iA(:,2),1,2);
E_help(:,1)=E_help(:,1)-ones(16,1);
E_help=(reshape(E_help',32,1)-ones(32,1))*32+transpose(1:32);
E1(E_help)=-1;


E2=zeros(48,16);
E_help=repmat(2*iS(:,2),1,2);
E_help(:,1)=E_help(:,1)-ones(24,1);
E_help=(reshape(E_help',48,1)-ones(48,1))*48+transpose(1:48);
E2(E_help)=-1;

E_help=repmat(2*iS(:,1),1,2);
E_help(:,1)=E_help(:,1)-ones(24,1);
E_help=(reshape(E_help',48,1)-ones(48,1))*48+transpose(1:48);
E2(E_help)=1;
