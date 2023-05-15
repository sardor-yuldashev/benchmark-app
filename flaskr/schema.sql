DROP TABLE IF EXISTS stations;
DROP TABLE IF EXISTS participants;
DROP TABLE IF EXISTS videos;
DROP TABLE IF EXISTS transcripts;

CREATE TABLE stations (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  load_percentage INTEGER NOT NULL,
  online_status BIT NOT NULL,
  title TEXT UNIQUE NOT NULL
);

CREATE TABLE participants (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  station_id INTEGER NOT NULL,
  video_count INTEGER NOT NULL,
  title TEXT NOT NULL,
  warning_label BIT NOT NULL,
  FOREIGN KEY (station_id) REFERENCES stations (id)
);

-- id, participant_id, title, source, format, fps, duration
CREATE TABLE videos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  participant_id INTEGER NOT NULL,
  title TEXT NOT NULL,
  source TEXT NOT NULL,
  format TEXT,
  fps FLOAT NOT NULL,
  duration FLOAT NOT NULL,
  FOREIGN KEY (participant_id) REFERENCES participants (id)
);

CREATE TABLE transcripts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  video_id INTEGER NOT NULL,
  body TEXT NOT NULL,
  start_time FLOAT NOT NULL,
  end_time FLOAT NOT NULL,
  FOREIGN KEY (video_id) REFERENCES videos (id)
);

-- hard coded data
INSERT INTO stations
VALUES
(1, 100, 1,'KANSAS1'),
(2, 100, 1, 'KANSAS2'),
(3, 99, 1,'NY1'),
(4, 0, 0,'NY2'),
(5, 65, 1,'PORTLAND1'),
(6, 99, 1, 'PORTLAND2'),
(7, 0, 0,'PORTLAND3'),
(8, 0, 0,'PORTLAND4');

INSERT INTO participants
VALUES
(1, 1, 10, 'kansas1_pr12635237283', 0),
(2, 1, 6, 'kansas1_pr12635237283', 1),
(3, 1, 8, 'kansas1_pr12635237283', 0),
(4, 1, 10, 'kansas1_pr12635237283', 0),
(5, 1, 10, 'kansas1_pr12635237283', 0),
(6, 1, 10, 'kansas1_pr1263523700', 0),
(7, 1, 8, 'kansas1_pr12635237101', 1),
(8, 1, 7, 'kansas1_pr12635237102', 1),
(9, 1, 1, 'kansas1_pr12635237103', 1),
(10, 1, 10, 'kansas1_pr12635237104', 0),
(11, 1, 12, 'kansas1_pr12635237105', 0),
(12, 1, 10, 'kansas1_pr12635237106', 0),
(13, 1, 10, 'kansas1_pr12635237107', 1),
(14, 1, 10, 'kansas1_pr12635237108', 0),
(15, 1, 4, 'kansas1_pr12635237209', 0),
(16, 1, 4, 'kansas1_pr12635237201', 0),
(17, 1, 4, 'kansas1_pr12635237202', 1),
(18, 1, 4, 'kansas1_pr12635237203', 1),
(19, 1, 4, 'kansas1_pr12635237204', 1),
(20, 1, 8, 'kansas1_pr12635237205', 0),
(21, 1, 10, 'kansas1_pr12635237206', 1),
(22, 1, 10, 'kansas1_pr12635237207', 1),

(23, 2, 6, 'kansas2_pr12635237283', 0),
(24, 2, 8, 'kansas2_pr12635237283', 0),
(25, 2, 10, 'kansas2_pr12635237283', 0),
(26, 2, 10, 'kansas2_pr12635237283', 0),
(27, 2, 10, 'kansas2_pr1263523700', 0),
(28, 2, 8, 'kansas2_pr12635237101', 0),
(29, 2, 7, 'kansas2_pr12635237102', 1),
(30, 2, 1, 'kansas2_pr12635237103', 0),
(31, 2, 10, 'kansas2_pr12635237104', 0),
(32, 2, 12, 'kansas2_pr12635237105', 1),
(33, 2, 10, 'kansas2_pr12635237106', 1),
(34, 2, 10, 'kansas2_pr12635237107', 1),

(35, 3, 10, 'ny1_pr12635237283', 1),
(36, 3, 6, 'ny1_pr12635237283', 1),
(37, 3, 8, 'ny1_pr12635237283', 0),
(38, 3, 10, 'ny1_pr12635237283', 0),
(39, 3, 10, 'ny1_pr12635237283', 0),
(40, 3, 10, 'ny1_pr1263523700', 0),
(41, 3, 8, 'ny1_pr12635237101', 1),
(42, 3, 7, 'ny1_pr12635237102', 1),
(43, 3, 1, 'ny1_pr12635237103', 1),
(44, 3, 10, 'ny1_pr12635237104', 0),
(45, 3, 12, 'ny1_pr12635237105', 0),
(46, 3, 10, 'ny1_pr12635237106', 0),
(47, 3, 10, 'ny1_pr12635237107', 0),
(48, 3, 10, 'ny1_pr12635237108', 1),
(49, 3, 4, 'ny1_pr12635237209', 0),
(50, 3, 4, 'ny1_pr12635237201', 0),
(51, 3, 4, 'ny1_pr12635237202', 1),
(52, 3, 4, 'ny1_pr12635237203', 0),

(53, 4, 10, 'ny2_pr12635237283', 0),
(54, 4, 6, 'ny2_pr12635237283', 0),
(55, 4, 8, 'ny2_pr12635237283', 1),
(56, 4, 10, 'ny2_pr12635237283', 0),
(57, 4, 10, 'ny2_pr12635237283', 0),
(58, 4, 10, 'ny2_pr1263523700', 1),
(59, 4, 8, 'ny2_pr12635237101', 1),
(60, 4, 7, 'ny2_pr12635237102', 0),
(61, 4, 1, 'ny2_pr12635237103', 0),
(62, 4, 10, 'ny2_pr12635237104', 0),
(63, 4, 12, 'ny2_pr12635237105', 1),
(64, 4, 10, 'ny2_pr12635237106', 1),
(65, 4, 10, 'ny2_pr12635237107', 0),
(66, 4, 10, 'ny2_pr12635237108', 0);

INSERT INTO videos
VALUES
(1, 1, "BigBuckBunny", "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", "aac, h264", 24, 596.474195),
(2, 1, "ElephantsDream", "https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", "aac, h264", 24, 653.804263),
(3, 1, "ForBiggerBlazes", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", "aac, h264", 23.98, 15.023311),
(4, 1, "ForBiggerEscapes", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4", "aac, h264", 24, 15.046531),

(5, 2, "ForBiggerFun", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4", "aac, h264", 23.98, 60.070023),
(6, 2, "ForBiggerJoyrides", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4", "aac, h264", 24, 15.046531),
(7, 2, "ForBiggerMeltdowns", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4", "aac, h264", 24, 15.046531),
(8, 2, "Sintel", "https://storage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4", "aac, h264", 24, 887.999),

(9, 3, "SubaruOutbackOnStreetAndDirt", "https://storage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4", "aac, h264", 29.97, 594.570159),
(10, 3, "TearsOfSteel", "https://storage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4", "aac, h264", 24, 734.261406),

(11, 4, "ForBiggerEscapes", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4", "aac, h264", 24, 15.046531),
(12, 4, "ForBiggerFun", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4", "aac, h264", 23.98, 60.070023),
(13, 4, "TearsOfSteel", "https://storage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4", "aac, h264", 24, 734.261406),
(14, 4, "ForBiggerJoyrides", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4", "aac, h264", 24, 15.046531),

(15, 5, "BigBuckBunny", "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", "aac, h264", 24, 596.474195),
(16, 5, "ElephantsDream", "https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", "aac, h264", 24, 653.804263),
(17, 5, "ForBiggerBlazes", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", "aac, h264", 23.98, 15.023311),
(18, 5, "ForBiggerEscapes", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4", "aac, h264", 24, 15.046531),

(19, 6, "BigBuckBunny", "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", "aac, h264", 24, 596.474195),
(20, 7, "ElephantsDream", "https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", "aac, h264", 24, 653.804263),
(21, 8, "ForBiggerBlazes", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", "aac, h264", 23.98, 15.023311),
(22, 9, "ForBiggerEscapes", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4", "aac, h264", 24, 15.046531),

(23, 10, "BigBuckBunny", "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", "aac, h264", 24, 596.474195),
(24, 10, "ElephantsDream", "https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", "aac, h264", 24, 653.804263),
(25, 10, "ForBiggerBlazes", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", "aac, h264", 23.98, 15.023311),
(26, 10, "ForBiggerEscapes", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4", "aac, h264", 24, 15.046531),

(27, 11, "BigBuckBunny", "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", "aac, h264", 24, 596.474195),
(28, 12, "ElephantsDream", "https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", "aac, h264", 24, 653.804263),
(29, 13, "ForBiggerBlazes", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", "aac, h264", 23.98, 15.023311),
(30, 14, "ForBiggerEscapes", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4", "aac, h264", 24, 15.046531),

(31, 15, "BigBuckBunny", "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", "aac, h264", 24, 596.474195),
(32, 16, "ElephantsDream", "https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", "aac, h264", 24, 653.804263),
(33, 17, "ForBiggerBlazes", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", "aac, h264", 23.98, 15.023311),
(34, 18, "ForBiggerEscapes", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4", "aac, h264", 24, 15.046531),

(35, 19, "BigBuckBunny", "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", "aac, h264", 24, 596.474195),
(36, 20, "ElephantsDream", "https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", "aac, h264", 24, 653.804263),
(37, 21, "ForBiggerBlazes", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", "aac, h264", 23.98, 15.023311),
(38, 22, "ForBiggerEscapes", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4", "aac, h264", 24, 15.046531),

(39, 23, "BigBuckBunny", "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", "aac, h264", 24, 596.474195),
(40, 24, "ElephantsDream", "https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", "aac, h264", 24, 653.804263),
(41, 25, "ForBiggerBlazes", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", "aac, h264", 23.98, 15.023311),
(42, 26, "ForBiggerEscapes", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4", "aac, h264", 24, 15.046531),

(43, 27, "BigBuckBunny", "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", "aac, h264", 24, 596.474195),
(44, 28, "ElephantsDream", "https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", "aac, h264", 24, 653.804263),
(45, 29, "ForBiggerBlazes", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", "aac, h264", 23.98, 15.023311),
(46, 30, "ForBiggerEscapes", "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4", "aac, h264", 24, 15.046531);