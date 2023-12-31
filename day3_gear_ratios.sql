-- https://adventofcode.com/2023/day/3
--- Day 3: Gear Ratios ---

-- You and the Elf eventually reach a gondola lift station; he says the gondola lift will take you up to the water source, but this is as far as he can bring you. You go inside.
-- 
-- It doesn't take long to find the gondolas, but there seems to be a problem: they're not moving.
-- 
-- "Aaah!"
-- 
-- You turn around to see a slightly-greasy Elf with a wrench and a look of surprise. "Sorry, I wasn't expecting anyone! The gondola lift isn't working right now; it'll still be a while before I can fix it." You offer to help.
-- 
-- The engineer explains that an engine part seems to be missing from the engine, but nobody can figure out which one. If you can add up all the part numbers in the engine schematic, it should be easy to work out which part is missing.
-- 
-- The engine schematic (your puzzle input) consists of a visual representation of the engine. There are lots of numbers and symbols you don't really understand, but apparently any number adjacent to a symbol, even diagonally, is a "part number" and should be included in your sum. (Periods (.) do not count as a symbol.)
-- 
-- Here is an example engine schematic:
-- 
-- 467..114..
-- ...*......
-- ..35..633.
-- ......#...
-- 617*......
-- .....+.58.
-- ..592.....
-- ......755.
-- ...$.*....
-- .664.598..
-- In this schematic, two numbers are not part numbers because they are not adjacent to a symbol: 114 (top right) and 58 (middle right). Every other number is adjacent to a symbol and so is a part number; their sum is 4361.
-- 
-- Of course, the actual engine schematic is much larger. What is the sum of all of the part numbers in the engine schematic?
-- 
-- Your puzzle answer was 525911.
-- 
-- --- Part Two ---
-- 
-- The engineer finds the missing part and installs it in the engine! As the engine springs to life, you jump in the closest gondola, finally ready to ascend to the water source.
-- 
-- You don't seem to be going very fast, though. Maybe something is still wrong? Fortunately, the gondola has a phone labeled "help", so you pick it up and the engineer answers.
-- 
-- Before you can explain the situation, she suggests that you look out the window. There stands the engineer, holding a phone in one hand and waving with the other. You're going so slowly that you haven't even left the station. You exit the gondola.
-- 
-- The missing part wasn't the only issue - one of the gears in the engine is wrong. A gear is any * symbol that is adjacent to exactly two part numbers. Its gear ratio is the result of multiplying those two numbers together.
-- 
-- This time, you need to find the gear ratio of every gear and add them all up so that the engineer can figure out which gear needs to be replaced.
-- 
-- Consider the same engine schematic again:
-- 
-- 467..114..
-- ...*......
-- ..35..633.
-- ......#...
-- 617*......
-- .....+.58.
-- ..592.....
-- ......755.
-- ...$.*....
-- .664.598..
-- In this schematic, there are two gears. The first is in the top left; it has part numbers 467 and 35, so its gear ratio is 16345. The second gear is in the lower right; its gear ratio is 451490. (The * adjacent to 617 is not a gear because it is only adjacent to one part number.) Adding up all of the gear ratios produces 467835.
-- 
-- What is the sum of all of the gear ratios in your engine schematic?
-- 
-- Your puzzle answer was 75805607.

SET search_path TO public;

\timing on
BEGIN;

CREATE TEMP TABLE input(line TEXT);

COPY input FROM STDIN;
...............307............130..................969...601...186.........................................312....628..........878..........
......479#../..*..............................#.....*......*............../309.....484........................*......-..........+.....89....
...........726..352...461..69..............435.....390...625....................................459.........152...-....580............*.....
.......................*.......454*674.448......65................257....104*762....&..............*269.........558.&.....*907.........652..
.....................164.....-..............532*.....................................484......108........955.........252..........321.......
.......270....*..............470.......................632....................*...................$............352...................*......
820........782.347...................*838..*371..475.......607...557.......201.29..............814....=.....15*....893..............143.....
...*..796...........449..138......991.....2........*....28....*.....*588.............................353..................*.................
582...../..333.............@..224............%....4.....*.....399........883..#859.........*341...........583*40.......366.951......170*814.
...............................*....*.....252......................551.....*.......91...374.....665.804*..........938...........694.........
...549.769..............527..466.169.712.......898.......408......*............-...*............*.......912.......*.......771%.../..........
.....*...=.875*342......$........................@........-.....846.........610..829.934*508...79............&691..48...................483.
....402.............................423-..............................465.........................342.....................@.................
..............837..................................264..................................*823.180....@.........%.........538............634..
..........807*....990+.................453............*277........657..379...........200.......*.............296..............767..885......
744...611................@........+.............500........866.....*......*..717............656..80...254................&775...%..*........
.......%.......*.2....878..793.97..143.413.&856......329*...*...732......878./.........191...............*..........+..............584......
.........535.506..............*.........-.................368.......................#.+........*.........429.......363......................
..564....*................966........................189......=............/24....939......26...547.......................193*241...........
.....*......................-..........................*...204........156......7............*................/.717*..................296....
..826.....924.......................956..............920..................259.-......$......286........6..955.........................=..457
......124*......................48.....=...435..............12.....886....*........411..........*170..%............90..-295.624.............
...........................290....*375.............747.....................175..........................653........*...........*............
..........642*157...........*.............................218.945..949&...................864+....720..*...........883.786-.....434..-..&...
...118.................@.....309...586............698.152....*..............250......*954........*......932...414...................239.39..
......@..999..574.......302..................53..=......*......933.69..............21.........538.............@................143..........
........*........+...........267..587*........*...........25......*..........241......289.........436.........................*.............
.......448.............437....*.......334...605......../..=...........689...%.........*...25.........*....97........171.780....813..836.....
......................*........169...............427...94.........389..$........360............/....692.....*......*......*.........%.......
......641...-..679.541..56.606...............490*.............871..........757.................612........64.....256...*...281..............
...........419...*......*..*..........................................*705...-.......................*.........@.......121..................
.......*.......786....738...28.........83.550........980...........915...............475..@.........524...=..145.349.................331....
....215.922.......................766.%....*.............993.................-.968..*.....301............205............................*...
............775..............273..*.........168.....504...$.....179.....+..466...*....352........850................771-.........-.......729
..699@........................*..174...............#........573*.......191.......567..*....925*....$......825..................543....&.....
........#....................939.......137...#..........474......../.................975........$.....219*............935............94.....
.....508...547....+.455..347.....593....&...56...140.......*246.198.....@....41...........46.476...........539...........+.15...............
...............210..........-.......*...............*773.............336....*..............+..........847.....*.............*.....957.......
...435...........................736...987.....573........32*............135.....60*405.........802*6...$......252....@...208.129*..........
.............187....353...............*..........*..504......276.........................#.........................838.............604......
..202...79....$........*..82-.............../.580......*..............181.......288......925.939....292......158..................*.........
.....................746.................381.......211..272...........*.....890....*215.........=...........*............953....22..........
.........................957......#..................*......../.......240....*............18.................294...766...............*......
.......483..434$........*.........184......#.....&..561.......354.........445....*626.......*174......................*54....603..432.457...
......#..........916.231..*178..........967...902........895..................135.............................207...............*...........
..941.....600...*...................31...............*.../............138*559.......19.803..........396.........&..377.....261...904........
...........*...146....#........626....*............809......199................@........*..............+.....#.......*.275*............%....
...........181.......459.486.....*.....912....787..........*..................847.....160.433.728.........901......404................899...
..........................*.....97...........*..............252..............................*.......+.........451........434..*............
...621...294..10.........913..........5..318.349.......749.......457......594........................326.........*..........%.884........494
.....*...*...-.........................$...........157.@........*..........*....&..951....524..869#..............405.................416....
....864.631....=......958..........................*....../.....953.......690..144..$.......*..........................204.&....%.......+...
750.............868....*.....430............882...98.......655..........................98.961...674........*.........*....955..530.........
...*..................459.......*929..........$...................281....-...............*......*.....38...688........878...................
.779....494.................+........-725............978..............134......2.......465....685.929*............759............351..291...
.....51*.......244....173..222..233........153*......*....123..............*.....324......................#.456.#...%...............-..@....
.........&....*.......$.............................542...*......77.......288...*....*51.......624......68....*.888....507..................
...213.367.953................................-667.......225.......*285.......506.177....*32.....*..........43........../...................
...#.................753.%........506.................................................131.....793...-.....-....................917$.147.....
.........275.............372.....$..........$........679.407..674..205#....406............647.....297..642.........621...............*......
.........*...................................173........*.....................*721........*.......................*....#207..........533....
.........68..............&.........274............322*...................707............280...............188..272..+...........223.........
.....553..................289.534.....%...830.........927..................*.176............*.............*..........217.........*..........
...................$..-.......-..........*................796*..........606...%...756...-.994....252.694..351.793$........930..230.....611..
.841%..659.237..356...116.............683...860...............494................$....127..............*....................*.........*.....
......#....................558..#891........*........418............&.............................22..323.....540...92....792.........408...
.................231*780....*.........*452.82........*........940..709....................662....*..............*...@...........432.........
....456.91...............972.....=.523.............949.837#........................823....*....627..............880....511.............203..
...$......@.........190.......162........508..........................158..861..........533.............749............................=....
......................*.............117..@....608....967.10............../........................&........$....................800.........
..752/...988.....82..281....894........*......-..................533.............692...............524.............=....623......@....939...
.........*...217*..............*.......51.........400...............&........200..@......435..484&........2*648.95..416.....................
.........319..................788....................*..279.......*.....................*...........321.........*..........464...286*....311
................733...457............*.............65...*.........620...205....457.782..513..342..........561.670.160..899.*.........607....
...............*.....+............397.....613/..........938.171...............*....................869......$.........*.....589.............
.............85..............=324.................189.........#.......808..578..-.........170*........*..&..........461.....................
......................992.............555........=...............375.....=.....599............336...835.282.....714.........................
...@......622.........%...............-....%....................*.....................705.287................../....955.426..140............
..202.....*...365.........$8....636*....148....................720............648......+...*................%........*...................220
.........223...+....................554........629...........*......785..............&.....460....*...#..848...24.948....961............*...
....................274..........................*...........995...........92.823.....958........185.983...............=..*....566....33....
.............146#....+....865.307................797...411................./..............577.......................245....935..............
....150...................*......*..560.................+...+298...............*....213.......984.......103.811.......................&.....
.......*..297..-905.822.643.....452....*333............................527..911.......*.........=.........*....*...............834.76.410...
..........+........../.......*...............774.....................................228..764-...........806..621.............*.....=.......
.......83.......753.......664.36..371..132.........341.......347...267........@813.............341*322..............237%.....134......$.....
....66*...630......*.238.............$.$......609.....*673.........*...920-...............%................937*873................844.807...
.........*......410.....#.........90..........%....-............789.........316.........755.932..$....................*921....363..=........
.........524........-.........52..........422...349......................15....*............*....550.........384..9.22........*.............
..............752....809..........$........*............#......397.......*..147....666.....83................*..............747......@474...
.......995......*............898.753.....305...........306......*......344............#....................985./................206=........
......*......172...............*...........................-..603..........*771...870...260....609..............588.....+503................
.....475.....................412.634*480..155....$824...845........409..367..........@..........*..498...............................893....
317......737.654.............................*97............781...*..............#......184..252..*....@.564*347......312*..............*...
............*.............658..........91.............402..*.....929.....346.....912......=......825.412.........908..........&..........500
.889..%.............471*...*...........*.........685-...+..208.........................*..................*291..*.............926.826.......
.......647...@..........84.929........518.375.........+.............%...............139................467......813.690...........*.........
...........276...................165.........%......778............412....594.619...............768........401..........195*861..70...$.....
......................1.....584.........+.......954...........299@..............*..............*......./../............................759..
........886..356.&784.......*........414.............................702.......128...+315.....302.....283....+.......309*231.......316......
..........$.............811....................*.............237....*.....................426.....713.......638.442............957*.........
....572...........491&..*......46............41.362.............*..361.700...883..478.......%.......*............./.....245.................
655*.......720...................*............................211.........*....*....*.........502.862.........*............+.......137......
.....302....*...............762..668.....446.............................552.....488.......................415.622.113.437........%.........
.190*.......362...581......#...............*...803.14.............&61.................$......972...479......................................
......760............=................478..627....*.......34*..........................51......=....%.....828............................531
........*.....764#...................*..............529............................356...........*.........-...................996*271..*...
220...58............721...508.872.634...........300*.........507.....290...........*..........356.780...36.....553.......................875
...............292.@......*............833.71...................*305.......382.....273................../.............998.........679.......
.........616..*......../..524.885.....-......*..527*538...794......../.....=....$........=....................812........*..........*.+297..
....579....*...629....666.................982...................467...468........292.....67........398...........*..283..225......550.......
241*.....415.....................832............................&...........&.................481..*.....444*826.....*......................
.....*..........................*.......$...920......600-..323#............930....591....357...*...653..............182.............816..575
..178.157...............186=..568.../...134....#....................292............*.....+....438..........+824...........859.814..#........
..........*209...462................606......%......405............*........*..334.623................*...................+...@.............
.......784......*............................632...@.......*....597........320.........219............210...........805.....................
595............664............&..%847.................$.749.434.....*894..........757...*..................$813......*.......&.%....278.191.
............................311.....................156.........244...............*....163....$...................706.....893..115...*......
.......451-...215...474.............610.687......................*..............535........424..........727*411.....................314.....
..............*................82.....*./....-.....482*307.....502.......595...................490..............590....*406.............309.
.............97.............................860...................................................*.......395...#...656.....................
......732........516......486......662*............*739...........=....579.............754......821..718...&..............609...753..103.62.
.908...*...........*.........*...........*824...197.....$......227...........956............331.......*......390.................*....*.....
....*...210......284.........821......148................644....................*....533.......*.....280....*.......-..........904.....748..
....368.......$.........542....................................*.411...........982...*....958.671........975.........610....................
...........820...358$....&..298........$....62...@....983..+..49.....254............784...*......................947.....................776
.....766.......................*......68.....#..477...$...428....209*.......*...265.......191......*........268...=....81...618#........=...
........*847.....661.474......624.........................................223...#....*...........74...................*.....................
.................*......%.574.....................976.475*618.@.....=..27.........975.280.....*......=...............13.....757-.......112..
.....721.........748.........*......392&.........../..........636.911......................359.......857.656....72-.....................*...
........*...................405..40...........87+..............................%89..............237.........#...................83....632...
........108...............................................172.54*.................................&...................%........*............
............736........3....727.....=.40...................*.........877.........=191.......................+...139.903........151.....%....
...725...56..%..410...$..@.....*...2...*....969.............207...../.......831........977.........158....946...*...................967.....
.....-....*......+......346..163......8........*..........@..................*.....509*.....458...*..............834...636@.....304......357
...-.......790......308........................453......396...........871..712..*.......625...%.426......777.423............................
..810.................%....355.421.....36.........................151...........935.774*........................#.......619.390.............
.............360*201..........*.......%...794...-..70......./24..*..........................765......*303.167.........*..&....-.........*...
.........*.......................273......%...198..*..............967................724=...*.....776........@.120.696......=.........37.301
......333.588.........205..........................572......................................673.........876..................893............
\.


-- we find all all digits that satisfy the proximity property, together with their positions on the board,
-- and fetch matching numbers by checking which number the digit position corresponds to. We convert the board
-- to a single-dimension, adding an extra '.' between dimensions to prevent digits that start the next line from
-- being concatenated to digits at the end of the current line. The planner tends to fold some of the CTE blocks
-- together, resulting in a horrible plan taking more than 30m to execute, so we add MATERIALIZED everywhere,
-- speeding it up in at least 200x.

-- A board from example is converted to the string
-- 467..114.....*........35..633.......#...617*...........+.58...592...........755....$.*.....664.598..
-- each character with position i is adjacent  to characters with positions:
-- pos +-1, pos - width, pos - width +-1, pos + width, pos + with +-1


WITH oneline (line) AS MATERIALIZED (
	SELECT string_agg(line||'.','') as line FROM input
),
all_numbers AS MATERIALIZED (
	SELECT x[1]::integer as num,
		   row_number() over () as r
	FROM
		regexp_matches((SELECT line FROM oneline LIMIT 1), '\d+', 'g') as x
),
positions AS MATERIALIZED (
	SELECT start_pos as start,
		   end_pos-1 as fin,
		   row_number() OVER () as idx
    FROM
		generate_series(1, (
			SELECT array_length(array_agg(num), 1)
			FROM all_numbers LIMIT 1)) i,
		regexp_instr(
			(SELECT line FROM oneline LIMIT 1), '\d+', 1, i) as start_pos,
		regexp_instr(
			(SELECT line FROM oneline LIMIT 1), '\d+', 1, i, 1) as end_pos
),
parsed(val, pos, kind) AS MATERIALIZED (
SELECT 
  substring(line from i for 1) as val,
  i as pos,
  CASE WHEN
	  substring(line from i for 1) between '0' and '9'
  THEN
	  'd'
  ELSE
	  's'
  END as kind
FROM
	oneline
CROSS JOIN
	generate_series(1, length(line)) i
WHERE 
	substring(line from i for 1) != '.'
),
digits (val, pos) AS MATERIALIZED (
	SELECT d.val, d.pos
	FROM
		parsed as d
	CROSS JOIN
		(SELECT length(line||'.') as width from input limit 1) as l
	WHERE d.kind = 'd'
	AND EXISTS
	(SELECT 1
    	FROM parsed s
 	   	WHERE s.kind = 's'
 		AND s.pos = 
	 		ANY(ARRAY[d.pos - 1,
		 		d.pos + 1,
		 		d.pos - l.width,
		 		d.pos - l.width - 1,
		 		d.pos - l.width + 1,
		 		d.pos + l.width,
		 		d.pos + l.width - 1,
		 		d.pos + l.width + 1]))
),
target_indexes as MATERIALIZED (
	SELECT DISTINCT p.idx
	FROM
		positions p JOIN digits d
		ON (d.pos BETWEEN p.start and p.fin)
)
SELECT sum(an.num) as part_1
FROM
	target_indexes ti join all_numbers an ON (ti.idx = an.r);

-- part 2

WITH oneline (line) AS MATERIALIZED (
	SELECT string_agg(line||'.','') as line FROM input
),
all_numbers AS MATERIALIZED (
	SELECT x[1]::integer as num,
		   row_number() over () as r
	FROM
		regexp_matches((SELECT line FROM oneline LIMIT 1), '\d+', 'g') as x
),
positions AS MATERIALIZED (
	SELECT start_pos as start,
		   end_pos-1 as fin,
		   row_number() OVER () as idx
	FROM
		generate_series(1, (
			SELECT array_length(array_agg(num), 1)
			FROM all_numbers LIMIT 1)) i,
		regexp_instr(
			(SELECT line FROM oneline LIMIT 1), '\d+', 1, i) as start_pos,
		regexp_instr(
			(SELECT line FROM oneline LIMIT 1), '\d+', 1, i, 1) as end_pos
),
parsed (val, pos, kind) AS MATERIALIZED (
	SELECT 
  		substring(line from i for 1) as val,
  		i as pos,
  		CASE WHEN
	  		substring(line from i for 1) between '0' and '9'
  		THEN
	  		'd'
  		WHEN
		  	substring(line from i for 1) = '*'
  		THEN
	  		's'
  		END as kind
	FROM
		oneline
	CROSS JOIN
		generate_series(1, length(line)) i
	WHERE 
		(substring(line from i for 1) between '0' and '9') OR
		(substring(line from i for 1) = '*')
),
digits (val, pos, gear) AS MATERIALIZED (
	SELECT unnest(x.vals), unnest(x.positions), s.pos
	FROM
		parsed as s
	CROSS JOIN
		(SELECT length(line||'.') as width from input limit 1) as l
	JOIN LATERAL(
		SELECT array_agg(d.val) as vals, array_agg(d.pos) as positions
		FROM parsed d
		WHERE d.kind = 'd'
			AND d.pos = ANY(ARRAY[s.pos - 1,
	 							s.pos + 1,
	 							s.pos - l.width,
	 							s.pos - l.width - 1,
	 							s.pos - l.width + 1,
	 							s.pos + l.width,
	 							s.pos + l.width - 1,
	 							s.pos + l.width + 1])
		) x on (true)						
	WHERE s.kind = 's'),
target_indexes(gear, indexes) as MATERIALIZED (
	SELECT d.gear, array_agg(distinct p.idx)
	FROM
		positions p JOIN
		digits d ON (d.pos BETWEEN p.start and p.fin)
	GROUP BY d.gear
	HAVING array_length(array_agg(distinct p.idx), 1) = 2
)
SELECT sum((SELECT num FROM all_numbers where r = indexes[1]) * (select num from all_numbers where r = indexes[2])) as part_2
FROM target_indexes;

COMMIT;

