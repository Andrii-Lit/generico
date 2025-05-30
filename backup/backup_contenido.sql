-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-05-2025 a las 11:52:48
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `miravereda2425`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contenido`
--

CREATE TABLE `contenido` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `genero` varchar(50) DEFAULT NULL,
  `nombre_dir` varchar(255) DEFAULT NULL,
  `duracion` int(11) DEFAULT NULL,
  `actores_principales` text DEFAULT NULL,
  `fecha_estreno` date DEFAULT NULL,
  `puntuacion_media` decimal(3,1) DEFAULT NULL,
  `poster_path` varchar(255) DEFAULT NULL,
  `changedTS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `contenido`
--

INSERT INTO `contenido` (`id`, `titulo`, `descripcion`, `genero`, `nombre_dir`, `duracion`, `actores_principales`, `fecha_estreno`, `puntuacion_media`, `poster_path`, `changedTS`) VALUES
(1, 'El Padrino', 'América, años 40. Don Vito Corleone (Marlon Brando) es el respetado y temido jefe de una de las cinco familias de la mafia de Nueva York. Tiene cuatro hijos: Connie (Talia Shire), el impulsivo Sonny (James Caan), el pusilánime Fredo (John Cazale) y Michael (Al Pacino), que no quiere saber nada de los negocios de su padre. Cuando Corleone, en contra de los consejos de Il consigliere Tom Hagen (Robert Duvall), se niega a participar en el negocio de las drogas, el jefe de otra banda ordena su asesinato. Empieza entonces una violenta y cruenta guerra entre las familias mafiosas. ', 'Drama / Crimen', 'Francis Ford Coppola', 175, 'Marlon Brando, Al Pacino, James Caan', '1972-03-24', 9.3, 'https://pics.filmaffinity.com/El_padrino-993414333-large.jpg', '2025-05-30 08:18:56'),
    
(2, 'Forrest Gump', 'Forrest Gump (Tom Hanks) sufre desde pequeño un cierto retraso mental. A pesar de todo, gracias a su tenacidad y a su buen corazón será protagonista de acontecimientos cruciales de su país durante varias décadas. Mientras pasan por su vida multitud de cosas en su mente siempre está presente la bella Jenny (Robin Wright), su gran amor desde la infancia, que junto a su madre será la persona más importante en su vida.', 'Drama / Romance', 'Robert Zemeckis', 142, 'Tom Hanks, Robin Wright, Gary Sinise', '1994-07-06', 8.8, 'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fpics.filmaffinity.com%2FForrest_Gump-212765827-large.jpg&f=1&nofb=1&ipt=555d631609a0b30ce2ca30977ef98e9d8fb987efc8cd4c39d6cfb4aba31129e1', '2025-05-30 08:04:55'),
    
(3, 'Inception', 'Dom Cobb (DiCaprio) es un experto en el arte de apropiarse, durante el sueño, de los secretos del subconsciente ajeno. La extraña habilidad de Cobb le ha convertido en un hombre muy cotizado en el mundo del espionaje, pero también lo ha condenado a ser un fugitivo y, por consiguiente, a renunciar a llevar una vida normal. Su única oportunidad para cambiar de vida será hacer exactamente lo contrario de lo que ha hecho siempre: la incepción, que consiste en implantar una idea en el subconsciente en lugar de sustraerla.Sin embargo, su plan se complica debido a la intervención de alguien que parece predecir cada uno de sus movimientos, alguien a quien sólo Cobb podrá descubrir.', 'Ciencia ficción / Thriller', 'Christopher Nolan', 148, 'Leonardo DiCaprio, Joseph Gordon-Levitt, Ellen Page', '2010-07-16', 8.7, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fflxt.tmsimg.com%2Fassets%2Fp7825626_p_v8_af.jpg&f=1&nofb=1&ipt=fece9982d47cd73c45d51e9ca363001c895c77ce7ee9d731e012133672df68b7', '2025-05-30 08:15:29'),

(4, 'El Señor de los Anillos: La Comunidad del Anillo', 'En la Tierra Media, el Señor Oscuro Sauron ordenó a los Elfos que forjaran los Grandes Anillos de Poder. Tres para los reyes Elfos, siete para los Señores Enanos, y nueve para los Hombres Mortales. Pero Saurón también forjó, en secreto, el Anillo Único, que tiene el poder de esclavizar toda la Tierra Media. Con la ayuda de sus amigos y de valientes aliados, el joven hobbit Frodo emprende un peligroso viaje con la misión de destruir el Anillo Único. Pero el malvado Sauron ordena la persecución del grupo, compuesto por Frodo y sus leales amigos hobbits, un mago, un hombre, un elfo y un enano. La misión es casi suicida pero necesaria, pues si Sauron con su ejército de orcos lograra recuperar el Anillo, sería el final de la Tierra Media.', 'Fantasía / Aventura', 'Peter Jackson', 178, 'Elijah Wood, Ian McKellen, Orlando Bloom', '2001-12-19', 8.8, 'https://m.media-amazon.com/images/I/51Qvs9i5a%2BL._AC_.jpg', '2025-05-28 09:01:25'),

(5, 'Pulp Fiction', 'Jules y Vincent, dos asesinos a sueldo con no demasiadas luces, trabajan para el gángster Marsellus Wallace. Vincent le confiesa a Jules que Marsellus le ha pedido que cuide de Mia, su atractiva mujer. Jules le recomienda prudencia porque es muy peligroso sobrepasarse con la novia del jefe. Cuando llega la hora de trabajar, ambos deben ponerse "manos a la obra". Su misión: recuperar un misterioso maletín.', 'Crimen / Drama', 'Quentin Tarantino', 154, 'John Travolta, Uma Thurman, Samuel L. Jackson', '1994-10-14', 8.9, 'https://m.media-amazon.com/images/I/71c05lTE03L._AC_SY679_.jpg', '2025-05-28 09:01:25'),

(6, 'La La Land', 'Mia (Emma Stone), una joven aspirante a actriz que trabaja como camarera mientras acude a castings, y Sebastian (Ryan Gosling), un pianista de jazz que se gana la vida tocando en sórdidos tugurios, se enamoran, pero su gran ambición por llegar a la cima en sus carreras artísticas amenaza con separarlos.', 'Musical / Romance', 'Damien Chazelle', 128, 'Ryan Gosling, Emma Stone', '2016-12-09', 8.0, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimage.tmdb.org%2Ft%2Fp%2Foriginal%2FlcYwCSTzCHv0Z2QRpfztt75JyYj.jpg&f=1&nofb=1&ipt=9fab3de2701902be0b8801a67bd18774a262b70ca66b2142bc62200dd73c3e7b', '2025-05-30 08:05:38'),

(7, 'Gladiador', 'En el año 180, el Imperio Romano domina todo el mundo conocido. Tras una gran victoria sobre los bárbaros del norte, el anciano emperador Marco Aurelio (Richard Harris) decide transferir el poder a Máximo (Russell Crowe), bravo general de sus ejércitos y hombre de inquebrantable lealtad al imperio. Pero su hijo Cómodo (Joaquin Phoenix), que aspiraba al trono, no lo acepta y trata de asesinar a Máximo.', 'Acción / Drama', 'Ridley Scott', 155, 'Russell Crowe, Joaquin Phoenix', '2000-05-05', 8.5, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2F1.bp.blogspot.com%2F-akwiv2qJ-9o%2FXupQNCHDiGI%2FAAAAAAAADLE%2FBQsBxNrwrl8MSvlpAgDuI4TlgAs1UKJ-gCLcBGAsYHQ%2Fs1600%2Fgladiator-522d2bd7f14a4.jpg&f=1&nofb=1&ipt=8214f092b4f2cd80b02a7a4c97b7b5186f1', '2025-05-30 08:08:26'),

(8, 'Matrix', 'Thomas Anderson es un brillante programador de una respetable compañía de software. Pero fuera del trabajo es Neo, un hacker que un día recibe una misteriosa visita...', 'Ciencia ficción / Acción', 'Lana Wachowski, Lilly Wachowski', 136, 'Keanu Reeves, Laurence Fishburne', '1999-03-31', 8.7, 'https://m.media-amazon.com/images/I/51vpnbwFHrL._AC_.jpg', '2025-05-28 09:01:25'),

(9, 'Titanic', 'Jack (DiCaprio), un joven artista, gana en una partida de cartas un pasaje para viajar a América en el Titanic, el transatlántico más grande y seguro jamás construido. A bordo conoce a Rose (Kate Winslet), una joven de una buena familia venida a menos que va a contraer un matrimonio de conveniencia con Cal (Billy Zane), un millonario engreído a quien sólo interesa el prestigioso apellido de su prometida. Jack y Rose se enamoran, pero el prometido y la madre de ella ponen todo tipo de trabas a su relación. Mientras, el gigantesco y lujoso transatlántico se aproxima hacia un inmenso iceberg.', 'Drama / Romance', 'James Cameron', 195, 'Leonardo DiCaprio, Kate Winslet', '1997-12-19', 7.8, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Foriginalvintagemovieposters.com%2Fwp-content%2Fuploads%2F2020%2F02%2FTITANIC-8567-scaled.jpg&f=1&nofb=1&ipt=7ad0fe22c4e727d7623e54745d3e1642f9550db05639ee39e3caebef4ff5c73d', '2025-05-30 08:10:12'),

(10, 'El Club de la lucha', 'Un joven hastiado de su gris y monótona vida lucha contra el insomnio. En un viaje en avión conoce a un carismático vendedor de jabón que sostiene una teoría muy particular: el perfeccionismo es cosa de gentes débiles; sólo la autodestrucción hace que la vida merezca la pena. Ambos deciden entonces fundar un club secreto de lucha, donde poder descargar sus frustaciones y su ira, que tendrá un éxito arrollador. ', 'Drama / Thriller', 'David Fincher', 139, 'Brad Pitt, Edward Norton', '1999-10-15', 8.8, 'https://m.media-amazon.com/images/I/51v5ZpFyaFL._AC_SY679_.jpg', '2025-05-30 08:11:12'),

(11, 'Interstellar', 'Al ver que la vida en la Tierra está llegando a su fin, un grupo de exploradores dirigidos por el piloto Cooper (McConaughey) y la científica Amelia (Hathaway) emprende una misión que puede ser la más importante de la historia de la humanidad: viajar más allá de nuestra galaxia para descubrir algún planeta en otra que pueda garantizar el futuro de la raza humana.', 'Ciencia ficción / Drama', 'Christopher Nolan', 169, 'Matthew McConaughey, Anne Hathaway', '2014-11-07', 8.6, 'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Ffc04.deviantart.net%2Ffs71%2Ff%2F2014%2F045%2Fa%2F2%2Finterstellar_by_visuasys-d6ibj30.jpg&f=1&nofb=1&ipt=40e450f22815f8d425ff00557720b273075838a00b1297914b8bc9ba64e51b6e', '2025-05-30 08:19:26'),

(12, 'El Gran Lebowski', 'El Nota (Jeff Bridges), un holgazán que vive en Los Angeles, es confundido un día por un par de matones con el millonario Jeffrey Lebowski, con quien sólo comparte nombre y apellido. Después de que orinen en su alfombra, el Nota inicia la búsqueda de "El gran Lebowski". De su encuentro surgirá un trato: el Nota recibirá una recompensa si consigue encontrar a la mujer del magnate.', 'Comedia / Crimen', 'Joel Coen, Ethan Coen', 117, 'Jeff Bridges, John Goodman', '1998-03-06', 8.1, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimages.justwatch.com%2Fposter%2F76802182%2Fs718&f=1&nofb=1&ipt=a2d925e102bfa3d5ed63e66eff80c0fd6f40db0b5b872320d3a6993e61ff4346', '2025-05-30 08:21:37'),

(13, 'Toy Story', 'Los juguetes de Andy, un niño de 6 años, temen que haya llegado su hora y que un nuevo regalo de cumpleaños les sustituya en el corazón de su dueño. Woody, un vaquero que ha sido hasta ahora el juguete favorito de Andy, trata de tranquilizarlos hasta que aparece Buzz Lightyear, un héroe espacial dotado de todo tipo de avances tecnológicos. Woody es relegado a un segundo plano. Su constante rivalidad se transformará en una gran amistad cuando ambos se pierden en la ciudad sin saber cómo volver a casa.', 'Animación / Aventura', 'John Lasseter', 81, 'Tom Hanks, Tim Allen', '1995-11-22', 8.3, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fpics.filmaffinity.com%2Ftoy_story-626273371-large.jpg&f=1&nofb=1&ipt=e125d41601314a3de0de0ca1c8af31e44893772cbebd0f93e2ed6e1a8efb3858', '2025-05-30 08:22:00'),

(14, 'La lista de Schindler', 'Oskar Schindler (Liam Neeson), un empresario alemán de gran talento para las relaciones públicas, busca ganarse la simpatía de los nazis de cara a su beneficio personal. Después de la invasión de Polonia por los alemanes en 1939, Schindler consigue, gracias a sus relaciones con los altos jerarcas nazis, la propiedad de una fábrica de Cracovia. Allí emplea a cientos de operarios judíos, cuya explotación le hace prosperar rápidamente, gracias sobre todo a su gerente Itzhak Stern (Ben Kingsley), también judío. Pero conforme la guerra avanza, Schindler y Stern comienzan ser conscientes de que a los judíos que contratan, los salvan de una muerte casi segura en el temible campo de concentración de Plaszow, que lidera el Comandante nazi Amon Goeth (Ralph Fiennes), un hombre cruel que disfruta ejecutando judíos.', 'Drama / Historia', 'Steven Spielberg', 195, 'Liam Neeson, Ben Kingsley', '1993-12-15', 8.9, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%3Fid%3DOIP.xYBbtWDsAno7WqLksl3XcQHaLb%26pid%3DApi&f=1&ipt=2525f2b984f23e7b01157e62f9bc6faca9a5673cf7d6470d44330571425f60a7', '2025-05-30 08:26:34'),

(15, 'Salvar al Soldado Ryan', 'Segunda Guerra Mundial, 1944. Tras el desembarco de los Aliados en Normandía, a un grupo de soldados americanos se le encomienda una peligrosa misión: poner a salvo al soldado James Ryan. Los hombres de la patrulla del capitán John Miller deben arriesgar sus vidas para encontrar a este soldado, cuyos tres hermanos han muerto en la guerra. Lo único que se sabe del soldado Ryan es que se lanzó con su escuadrón de paracaidistas detrás de las líneas enemigas.', 'Guerra / Drama', 'Steven Spielberg', 169, 'Tom Hanks, Matt Damon', '1998-07-24', 8.6, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.ecured.cu%2Fimages%2Fthumb%2F0%2F01%2FSalvar_al_soldado_Ryan.jpg%2F1200px-Salvar_al_soldado_Ryan.jpg&f=1&nofb=1&ipt=781cff29fe18edb3e5839d9cb4bd9017177484ad078e4ea904581af567c7f38e', '2025-05-30 08:27:21'),

(16, 'El Rey León', 'La sabana africana es el escenario en el que tienen lugar las aventuras de Simba, un pequeño león que es el heredero del trono. Sin embargo, al ser injustamente acusado por el malvado Scar de la muerte de su padre, se ve obligado a exiliarse. Durante su destierro, hará buenas amistades e intentará regresar para recuperar lo que legítimamente le corresponde.', 'Animación / Aventura', 'Roger Allers, Rob Minkoff', 88, 'Matthew Broderick, James Earl Jones', '1994-06-24', 8.5, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.themoviedb.org%2Ft%2Fp%2Foriginal%2Fr7DEmhFWpXWnYU9nbQhx3gPJovS.jpg&f=1&nofb=1&ipt=c9aa39fd1a46861caafeb593299efe487f3c6e8ec1e1c212c9eb0960807e837c', '2025-05-30 08:28:44'),

(17, 'El Pianista', 'Wladyslaw Szpilman, un brillante pianista polaco de origen judío, vive con su familia en el ghetto de Varsovia. Cuando, en 1939, los alemanes invaden Polonia, consigue evitar la deportación gracias a la ayuda de algunos amigos. Pero tendrá que vivir escondido y completamente aislado durante mucho tiempo, y para sobrevivir tendrá que afrontar constantes peligros.', 'Drama / Historia', 'Roman Polanski', 150, 'Adrien Brody', '2002-09-24', 8.5, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fes.web.img2.acsta.net%2Fpictures%2F14%2F05%2F27%2F12%2F07%2F438875.jpg&f=1&nofb=1&ipt=fe0923ac8a139bafc691038b5e36c4b17ec90038cfdca261a2ee1b6926362b8c', '2025-05-30 08:30:54'),

(18, 'Memento', 'La memoria de Leonard, un investigador de una agencia de seguros, está irreversiblemente dañada debido a un golpe sufrido en la cabeza cuando intentaba evitar el asesinato de su mujer: éste es el último hecho que recuerda del pasado. La memoria reciente la ha perdido: los hechos cotidianos desaparecen de su mente en unos minutos. Así pues, para investigar e intentar vengar el asesinato de su esposa tiene que recurrir a la ayuda de una cámara instantánea y a las notas tatuadas en su cuerpo.', 'Thriller / Misterio', 'Christopher Nolan', 113, 'Guy Pearce, Carrie-Anne Moss', '2000-09-05', 8.4, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.themoviedb.org%2Ft%2Fp%2Foriginal%2FbDgEwnPFcPrJcM5xvkt8EphZ9A3.jpg&f=1&nofb=1&ipt=c663c2d2a6f3740fca9f9c670f4426499bebe1631f9ecd39d80312132b8973d7', '2025-05-30 08:32:46'),

(19, 'La guerra de las galaxias. Episodio V: El imperio contraataca', 'Tras un ataque sorpresa de las tropas imperiales a las bases camufladas de la alianza rebelde, Luke Skywalker, en compañía de R2D2, parte hacia el planeta Dagobah en busca de Yoda, el último maestro Jedi, para que le enseñe los secretos de la Fuerza. Mientras, Han Solo, la princesa Leia, Chewbacca, y C3PO esquivan a las fuerzas imperiales y piden refugio al antiguo propietario del Halcón Milenario, Lando Calrissian, en la ciudad minera de Bespin, donde les prepara una trampa urdida por Darth Vader.', 'Ciencia ficción / Aventura', 'Irvin Kershner', 124, 'Mark Hamill, Harrison Ford', '1980-05-21', 8.7, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fhttp2.mlstatic.com%2FD_NQ_NP_725340-MCO48589692950_122021-O.webp&f=1&nofb=1&ipt=a06ab4ce01e1db302f4064ebdadd751f60798403bc189d1838f3bdda1cf035a6', '2025-05-30 08:34:07'),

(20, 'Ready Player One ', 'Año 2045. Wade Watts es un adolescente al que le gusta evadirse del cada vez más sombrío mundo real a través de una popular utopía virtual a escala global llamada "Oasis". Un día, su excéntrico y multimillonario creador muere, pero antes ofrece su fortuna y el destino de su empresa al ganador de una elaborada búsqueda del tesoro a través de los rincones más inhóspitos de su creación. Será el punto de partida para que Wade se enfrente a jugadores, poderosos enemigos corporativos y otros competidores despiadados, dispuestos a hacer lo que sea, tanto dentro de "Oasis" como del mundo real, para hacerse con el premio.', 'Ciencia ficción. Aventuras. Acción | Distopía', 'Steven Spielberg', 140, 'Tye Sheridan, Olivia Cooke', '2018-03-29', 6.3, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimage.tmdb.org%2Ft%2Fp%2Foriginal%2FsbDIPdRmnviCD55qhaoNVpIT794.jpg&f=1&nofb=1&ipt=618d509a2fe01b3e4c539ec3416f0ba1b1653904d62bf7ba8926927e2b6b0401', '2025-05-30 08:04:05');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `contenido`
--
ALTER TABLE `contenido`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
