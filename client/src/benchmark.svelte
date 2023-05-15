<script>

    import Participants from "./participants.svelte";
    import Player from "./player.svelte";
    import Stations from "./stations.svelte";
    import axios from 'axios';

    let participants = [];

    async function get_participants(id, state) {
        if (state){
            try {
                await axios.get(`/benchmark/participants/${id}`, {
                    headers: {
                        'Access-Control-Allow-Origin': '*',
                        'Content-Type': 'application/json',
                    },
                }).then((response) => {
                    let new_participants = []
                    for(let i = 0; i < response.data.length; i++){
                        let id = response.data[i][0];
                        let station_id = response.data[i][1];
                        let video_count = response.data[i][2];
                        let name = response.data[i][3];
                        let warning_label = response.data[i][4];
                        new_participants.push({id:id, station_id:station_id, video_count:video_count, state:false, name:name, warning_label:warning_label});
                    }
                    let old_participants = participants;
                    participants = old_participants.concat(new_participants);
                })
            } catch (e) {
                error = e;
            }
        }else{
            let new_participants = participants.filter(participant => participant.station_id !== id);
            participants = new_participants;
        }
	}

    function updateParticipants(event){
        let id = event.detail.id;
        let state = event.detail.state;
        get_participants(id, state);
    }

    let videos = [];

    async function get_videos(id, state) {
        if (state){
            try {
                await axios.get(`/benchmark/videos/${id}`, {
                    headers: {
                        'Access-Control-Allow-Origin': '*',
                        'Content-Type': 'application/json',
                    },
                }).then((response) => {
                    let new_videos = []
                    for(let i = 0; i < response.data.length; i++){
                        let id = response.data[i][0];
                        let participant_id = response.data[i][1];
                        let name = response.data[i][2];
                        let source = response.data[i][3];
                        let format = response.data[i][4];
                        let fps = response.data[i][5];
                        let duration = response.data[i][6];
                        new_videos.push({id:id, participant_id:participant_id, name:name, source:source, format:format, fps:fps, duration:duration});
                    }
                    let old_videos = videos;
                    videos = old_videos.concat(new_videos);
                })
            } catch (e) {
                error = e;
            }
        }else{
            let new_videos = videos.filter(video => video.participant_id !== id);
            videos = new_videos;
        }
        console.log(videos);
	}

    function updateVideos(event){
        let id = event.detail.id;
        let state = event.detail.state;
        get_videos(id, state);
    }

</script>

<div class="p-2 w-full h-full grid grid-rows-4 grid-cols-5 grid-flow-col gap-2 min-h-0">

    <div class="col-span-1 row-span-4 border-2 border-slate-200 overflow-auto">
        <Stations on:message={updateParticipants}/>
    </div>

    <div class="col-span-1 row-span-4 border-2 border-slate-200 overflow-auto">
        <Participants participants={participants} on:message={updateVideos}/>
    </div>

    <div class="col-span-3 row-span-4 border-2 border-slate-200 overflow-auto">
        <Player videos={videos}/>
    </div>

</div>