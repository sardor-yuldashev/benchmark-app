<script>

    import axios from 'axios';
    import { onMount } from 'svelte';
    import { Icon } from 'svelte-awesome';
    import { createEventDispatcher } from 'svelte';
    import server from 'svelte-awesome/icons/server';
    import exchange from 'svelte-awesome/icons/exchange';
    import refresh from 'svelte-awesome/icons/refresh';
    import sortAmountAsc from 'svelte-awesome/icons/sortAmountAsc';
    import sortAmountDesc from 'svelte-awesome/icons/sortAmountDesc';
    import checkSquare from 'svelte-awesome/icons/checkSquare';
    import square from 'svelte-awesome/icons/square';

    let stations = [];
    const dispatch = createEventDispatcher();

    // update this on response
    let selected_count = 0;
    let all_stations = false;

    function toggle_station(id){
        let idx = stations.findIndex(station => station.id === id);
        if (idx > -1){
            let new_stations = stations;
            let new_state;
            if(stations[idx].state){
                selected_count -= 1;
                new_state = false;
            }else{
                selected_count += 1;
                new_state = true;
            }
            new_stations[idx].state = new_state;
            stations = new_stations;
            dispatch('message', {
			    state: new_state, id: new_stations[idx].id
		    });
        }
    }

    function toggle_all_stations(){
        if (all_stations){
            let new_stations = stations;
            for (let i = 0; i < new_stations.length; i++){
                new_stations[i].state = false;
                dispatch('message', {
		    	    state: false, id: new_stations[i].id
		        });
            }
            stations = new_stations;
            selected_count = 0;
            all_stations = false;
        }else{
            let new_stations = stations;
            // i will fix this later i promise
            // ------------------------------------------
            for (let i = 0; i < new_stations.length; i++){
                new_stations[i].state = false;
                dispatch('message', {
		    	    state: false, id: new_stations[i].id
		        });
            }
            stations = new_stations;
            // selected_count = 0;
            // -------------------------------------------
            for (let i = 0; i < new_stations.length; i++){
                new_stations[i].state = true;
                dispatch('message', {
		    	    state: true, id: new_stations[i].id
		        });
            }
            stations = new_stations;
            selected_count = new_stations.length;
            all_stations = true;
        }
    }

    async function get_stations(){
        let error = null;
        try {
            await axios.get('/benchmark/stations', {
                headers: {
                    'Access-Control-Allow-Origin': '*',
                    'Content-Type': 'application/json',
                },
            }).then((response) => {
                let new_stations = []
                for(let i = 0; i < response.data.length; i++){
                    let id = response.data[i][0]        // id
                    let load = response.data[i][1]      // load %
                    let online = response.data[i][2]    // online status
                    let state = false;                  // is toggled?
                    let name = response.data[i][3]      // station name
                    new_stations.push({id:id, online:online, load:load, state:state, name:name});
                }
                stations = new_stations;
            })
        } catch (e) {
            error = e;
        }
	}

    onMount(async () => {
        get_stations();
	});

</script>

<div class="flex flex-col w-full h-full">

    <div class="flex flex-col">
        <div class="flex flex-row gap-1 shrink-0 h-12 bg-slate-700 justify-between px-4">
            <button on:click={() => get_stations()} class="flex my-auto"><Icon class="w-4 h-4 text-white" data={refresh}/></button>
            <button on:click={() => toggle_all_stations()} class="flex my-auto"><Icon class="w-4 h-4 text-white" data={all_stations ? checkSquare : square}/></button>
            <button class="flex my-auto"><Icon class="w-4 h-4 text-white rotate-180" data={sortAmountDesc}/></button>
            <button class="flex my-auto"><Icon class="w-4 h-4 text-white rotate-180" data={sortAmountAsc}/></button>
        </div>
        <div class="flex flex-col w-full bg-slate-500">
            <div class="flex justify-between p-2">
                <div class="flex gap-2">
                    <Icon class="w-6 h-6 text-slate-400" data={server}/>
                    <h1 class="text-slate-200 whitespace-nowrap">Stations: </h1>
                </div>
                <p class="text-white whitespace-nowrap">{selected_count} <span class="text-slate-400">of</span> {stations.length}</p>
            </div>
        </div>
    </div>

    <ul class="w-full h-full overflow-auto">
        {#each stations as station}
            <li class="w-full">
                <button class="flex align-middle justify-between my-1 p-2 w-full h-full text-left {station.state ? 'text-blue-600 bg-slate-200' : 'text-slate-500'} border-b-2 border-neutral-100 border-opacity-100 dark:border-opacity-50" on:click={() => toggle_station(station.id)}>
                    {station.name}
                    <div class="flex my-auto align-middle gap-1">
                        <p class="text-xs">{station.load}%</p>
                        <Icon class="my-auto w-3 h-3 rotate-90" data={exchange}/>
                        <div class="my-auto rounded-full {station.online ? 'bg-green-400' : 'bg-red-400'} w-3 h-3"></div>
                    </div>
                </button>
            </li>
        {/each}
    </ul>

</div>