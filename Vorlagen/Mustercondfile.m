%multiple-conditions-File f�r SPM-Model Specification
%Kommentar nach Prozentzeichen beliebig erg�nzen
%Anleitung zur Benutzung:
%Namen, onsets und durations nach dem erkennbaren Schema erg�nzen und ggf. �berschreiben
%in matlab-Fenster links oben Workspace aktivieren
%Matlab-Men� Edit: clear workspace 
%hier in Editor-Symbolleiste Icon mit 2 Seiten mit rotem Pfeil anklicken
%in matlab Men�-Edit - select all
%matlab File - Save workspace as ... mat-File
%
names=cell(1,2)
onsets=cell(1,2)
durations=cell(1,2)
names{1}='Ruhe'
onsets{1}=[ 
1
21
41
61
81
101
121
141
161
181
201
]
durations{1}=[10]

names{2}='Aktivierung'
onsets{2}=[
11
31
51
71
91
111
131
151
171
191
]
durations{2}=[10]
names{3}='P_off'
