clc
clearvars
Nelem = input('Cantidad de elementos = ');
matriz8x8 =  zeros(Nelem*2);
E1 = 2*(10^6);
E2 = 2*(10^7);
A1 = 0.15;
A2 = 2*(10^(-3));
for x = 1:Nelem
    disp('Para este caso se recomienda ingresar:')
    disp('1) E:E1 A:A1 x:0 y:6 Nodo1:1 Nodo2:2')
    disp('2) E:E1 A:A1 x:8 y:0 Nodo1:2 Nodo2:3')
    disp('3) E:E2 A:A2 x:8 y:6 Nodo1:1 Nodo2:3')
    disp('4) E:E2 A:A2 x:0 y:6 Nodo1:3 Nodo2:4')
    E = input('E = ');
    A = input('A = ');
    disp('Siendo x: Largo horizontal e y: Largo vertical')
    cx = input('x = ');
    cy = input('y = ');
    L = sqrt(cx^2 + cy^2)
    Es = (E*A)/L;  %Escalar matriz
    if cx == 0
        alpha= pi/2
    else
    alpha = tan(cy/cx) %ángulo
    end
    c = cos(alpha);
    s = sin(alpha);
    
    disp('Los nodos corresponden a:')
    disp('A=1 B=2 C=3 D=4')
        inter1 = input('Nodo1: ');
        inter2 = input('Nodo2: ');
    matriz = Es*[c^2 s*c -c^2 -s*c; s*c s^2 -s*c -s^2; -c^2 -s*c c^2 s*c; -s*c -s^2 s*c s^2]   
cord1 = (inter1*2)-1;
cord2 = inter1*2;
cord3 = (inter2*2)-1;
cord4 = inter2*2;
m = matriz;

matriz8x8(cord1,cord1) = m(1,1) + matriz8x8(cord1,cord1);
matriz8x8(cord2,cord1) = m(2,1) + matriz8x8(cord2,cord1);
matriz8x8(cord3,cord1) = m(3,1) + matriz8x8(cord3,cord1);
matriz8x8(cord4,cord1) = m(4,1) + matriz8x8(cord4,cord1);

matriz8x8(cord1,cord2) = m(1,2) + matriz8x8(cord1,cord2);
matriz8x8(cord2,cord2) = m(2,2) + matriz8x8(cord2,cord2);
matriz8x8(cord3,cord2) = m(3,2) + matriz8x8(cord3,cord2);
matriz8x8(cord4,cord2) = m(4,2) + matriz8x8(cord4,cord2);

matriz8x8(cord1,cord3) = m(1,3) + matriz8x8(cord1,cord3);
matriz8x8(cord2,cord3) = m(2,3) + matriz8x8(cord2,cord3);
matriz8x8(cord3,cord3) = m(3,3) + matriz8x8(cord3,cord3);
matriz8x8(cord4,cord3) = m(4,3) + matriz8x8(cord4,cord3);

matriz8x8(cord1,cord4) = m(1,4) + matriz8x8(cord1,cord4);
matriz8x8(cord2,cord4) = m(2,4) + matriz8x8(cord2,cord4);
matriz8x8(cord3,cord4) = m(3,4) + matriz8x8(cord3,cord4);
matriz8x8(cord4,cord4) = m(4,4) + matriz8x8(cord4,cord4);
    
end
matriz8x8
H = matriz8x8;
n= 0;
f = 0;
T = 40; 

%cálculo de fuerzas previo
alpha_F = 10^-5; 
F3 = E2*A2*T*alpha_F; % Carga termica sobre c y d 
F4 = F3; 
%Vector de cargas en punto C 
angC = atan(6/8); 
F3x = F3 * cos(angC); 
F3y = F3 * sin(angC); 
Pcx = F3x; 
Pcy = F3y + F4; 
Fuerza = zeros(8,1); 
vec = zeros(1,8); %vector auxiliar 
for x = 1:(Nelem*2)
    n = n + 1
    disp('Significado de n ')
    disp('1:u1 2:v1 3:u2 4:v2 5:u3 6:v3 7:u4 8:v4 ')
    disp('El desplazamiento es nulo de n es nulo si=0 no=1')
    disp('para este caso 0 0 1 1 1 1 0 0')
    ele = input('1 o 0: ')
    vec(1,x) = ele;
    disp('Para este caso se recomienda:')
    disp('0 0 0 0 Pcx Pcy 0 0')
    Fuerza(x,1) = input('Ingrese valor Fuerza: ');
    if ele==0
        u = 1 + f; %contador
        H(u,:) = [];
        H(:,u) = [];
    else
        f = f +1;
        
    end
        
end
F = 0;
U = 0;
for x = 1:(Nelem*2)
    if vec(1,x)==0
        U = 1 + F;
        Fuerza(U,:) = [];
    else
        F = F +1;
    end
end

H %matriz reducida
Fuerza %vector fuerza reducido
disp('Para este caso los valores presentados corresponden a')
syms u2 v2 u3 v3
Desplazamientos = [u2; v2; u3; v3]
desplazamientos = H\Fuerza

