
G_retardada = tf(3, [1 2 3], 'InputDelay', 2);

% =========================================================================
% TAREAS 5 Y 6: Respuesta a suma de escalones
% =========================================================================
% Se define el vector de tiempo de 0 a 30 segundos.
t_t56 = 0:0.01:30;

% Construcción de la señal mediante comparaciones lógicas (devuelven 1 o 0).
% Se suman dos escalones de amplitud 5 en t=10s y t=20s.
u_t56 = 5*(t_t56 >= 10) + 5*(t_t56 >= 20);      

% lsim(...): Simula la respuesta de la planta (G_retardada) ante la entrada arbitraria (u_t56).
[y_t56, t_t56] = lsim(G_retardada, u_t56, t_t56);

% max(...): Encuentra el valor máximo del vector de salida y el índice donde ocurre.
[pico_t56, k_t56] = max(y_t56);                  
t_t56(k_t56) % Se imprime en consola el instante de tiempo del máximo.

% figure y plot(...): Genera la gráfica superponiendo la entrada (gris) y salida (azul).
figure; 
plot(t_t56, u_t56, 'Color', [.6 .6 .6]); hold on;
plot(t_t56, y_t56, 'LineWidth', 1.5); grid on;

% Se marca el punto máximo encontrado utilizando una 'x' de color rojo ('rx').
plot(t_t56(k_t56), pico_t56, 'rx', 'MarkerSize', 12);
xlabel('Tiempo [s]'); ylabel('Amplitud');
legend('Entrada', 'Salida');
saveas(gcf, 'T2_arbitraria1.png');

% =========================================================================
% TAREA 7: Respuesta a señal combinada (escalón y rampa)
% =========================================================================
% Se amplía el vector de tiempo a 40 segundos.
t_t7 = 0:0.01:40;

% Construcción por tramos usando compuertas lógicas AND (&) como máscaras.
u_t7 = 5*(t_t7 >= 10 & t_t7 < 20);           % Tramo 1: escalón de amplitud 5
idx_t7 = (t_t7 >= 20 & t_t7 < 30);           % Se crea una máscara para el tramo 2
u_t7(idx_t7) = 15 + (t_t7(idx_t7) - 20);     % Tramo 2: rampa ascendente
u_t7(t_t7 >= 30) = 25;                       % Tramo 3: se mantiene el valor final

% Simulación con lsim y búsqueda del máximo.
[y_t7, t_t7] = lsim(G_retardada, u_t7, t_t7);
[pico_t7, k_t7] = max(y_t7);
t_t7(k_t7)

% Graficación de las señales y marcado del pico máximo.
figure; 
plot(t_t7, u_t7, 'Color', [.6 .6 .6]); hold on;
plot(t_t7, y_t7, 'LineWidth', 1.5); grid on;
plot(t_t7(k_t7), pico_t7, 'rx', 'MarkerSize', 12);
xlabel('Tiempo [s]'); ylabel('Amplitud');
legend('Entrada', 'Salida');
saveas(gcf, 'T2_arbitraria2.png');

% =========================================================================
% TAREA 8: Reto - Diseño de señal propia por tramos
% =========================================================================
% 1. Definir el vector de tiempo (50 segundos en total, cumpliendo la restricción >40s)
t_t8 = 0:0.01:50;

% zeros(...): Inicializa la señal 'u_t8' como un vector de ceros del mismo tamaño que 't_t8'.
u_t8 = zeros(size(t_t8)); 

% Construcción de la señal por tramos usando máscaras lógicas:
% Tramo 1: Rampa ascendente (de t=5 a t=15, sube de 0 a 10)
tramo1_t8 = (t_t8 >= 5 & t_t8 < 15);
u_t8(tramo1_t8) = t_t8(tramo1_t8) - 5;

% Tramo 2: Escalón de bajada (de t=15 a t=25, cae y se mantiene en 4)
u_t8(t_t8 >= 15 & t_t8 < 25) = 4;

% Tramo 3: Escalón de subida (de t=25 a t=35, sube y se mantiene en 12)
u_t8(t_t8 >= 25 & t_t8 < 35) = 12;

% Tramo 4: Rampa descendente (de t=35 a t=45, baja de 12 a 2)
tramo2_t8 = (t_t8 >= 35 & t_t8 < 45);
u_t8(tramo2_t8) = 12 - (t_t8(tramo2_t8) - 35);

% Tramo 5: Mantenimiento del valor final
u_t8(t_t8 >= 45) = 2;

% lsim(...): Simula la respuesta de la planta G_retardada ante la señal compleja.
[y_t8, t_t8] = lsim(G_retardada, u_t8, t_t8);

% max(...): Encuentra el valor máximo del vector de salida 'y_t8' y su índice posicional 'k_t8'.
[pico_t8, k_t8] = max(y_t8);

% fprintf(...): Imprime formateado en consola el valor pico y su instante temporal.
fprintf('El valor máximo de la respuesta es %.2f. En t = %.2f s\n', pico_t8, t_t8(k_t8));

% figure y plot(...): Configuración de la gráfica superpuesta.
figure('Name', 'Reto T8', 'NumberTitle', 'off');
plot(t_t8, u_t8, 'Color', [.6 .6 .6], 'LineWidth', 1.5); hold on;
plot(t_t8, y_t8, 'b', 'LineWidth', 1.5); grid on;

% plot(...): Marca el punto máximo detectado usando una cruz roja ('rx').
plot(t_t8(k_t8), pico_t8, 'rx', 'MarkerSize', 12, 'LineWidth', 2);

xlabel('Tiempo [s]'); ylabel('Amplitud');
title('Respuesta del sistema ante señal por tramos (Reto T8)');
legend('Entrada u(t)', 'Salida y(t)', 'Pico Máximo', 'Location', 'best');
saveas(gcf, 'T8_reto.png');