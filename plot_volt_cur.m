printf ("%s", program_name ());
arg_list = argv ();
for i = 1:nargin
	  printf (" %s", arg_list{i});
end
printf ("\n");

plot_power=false;
plot_merror=false;
plot_merror_shift=false;
plot_sequence=false;
plot_drift=false;

%filename='oldplug_nolamp1';
%filename='newplug_nolamp8';
%filename='nolamp0';
%filename='newplug_lamp10';
%filename='lamp0';
%filename='newplug/noload';
filename=arg_list{1};

x0=load([filename '.volt']);
x1=load([filename '.current']);
	
M=1;
Mp=19;
%p=p/100;
%plot(p)
%ylim([0 50000]);
%return

b(1,:,:)=x0;
b(2,:,:)=x1;
	
f=0;

for p=1:2

	if (plot_drift) 
		f=f+1;
		figure(f)
		M=100;
		plot(b(p,5:M,:));
	end

	f=f+1;
	figure(f)

	N=M+Mp;
	rvals = linspace(0,1,N);
	for i=M:N
		x(:,:)=b(p,i,:);
		xx=x(2:end,:);
		plot(xx, 'Color', [rvals(i), 0.2, 0.8])
		hold on
		if (p == 1)
			title("Voltage");
		else
			title("Current");
		end
	%	ylim([-1000 1000]);
	end

	%y=mean(p,3);
	%plot(y(1:size(p,3)), 'Color', [0 0 0]);
	
	hold off
end

if (plot_power)
	f=f+1;
	figure(f)

	for i=1:N
		volt(:,:)=b(1,i,:);
		cur(:,:)=b(2,i,:);
		x=volt.*cur;
		plot(x, 'Color', [rvals(i), 0.2, 0.8])
		hold on
	end
	hold off
end

if (plot_merror) 
	f=f+1;
	figure(f)

	T=size(b,2);
	%T=200;
	for i=1:T
		volt(:,:)=b(1,i,:);
		cur(:,:)=b(2,i,:);
		x=volt.*cur;
		mm(i)=mean(x);
	end
	plot(mm)
end

if (plot_merror_shift) 
	f=f+1;
	figure(f)

	volt_multiplier=0.2;
	cur_multiplier=0.0044;
	volt_zero=1.993;
	cur_zero=1.980;
	power_zero=3497;

	T=size(b,2);
	for i=1:T
		volt(:,:)=(b(1,i,:) - volt_zero) * volt_multiplier;
		cur(:,:)=(b(2,i,:) - cur_zero) * cur_multiplier;
		x=volt .* cur;
		mm(i)=mean(x);
	end
	mean(mm)

	mcorr=mm-power_zero;

	plot(mcorr)
end

if (plot_sequence)

	f=f+1;
	figure(f)

	m=[1];
	for i=1:length(m)
		xx1=repmat(x1(m(i),:),1,4);
		plot(xx1);
		hold on
		plot(x1(m(i),:),'r');
	end

end

% do not close script at the end (to show visualization)
pause
