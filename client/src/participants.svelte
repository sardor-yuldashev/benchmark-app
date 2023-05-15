<script>

    import { Icon } from 'svelte-awesome';    
    import refresh from 'svelte-awesome/icons/refresh';
    import sortAmountAsc from 'svelte-awesome/icons/sortAmountAsc';
    import sortAmountDesc from 'svelte-awesome/icons/sortAmountDesc';
    import users from 'svelte-awesome/icons/users';
    import warning from 'svelte-awesome/icons/warning';
    import checkSquare from 'svelte-awesome/icons/checkSquare';
    import square from 'svelte-awesome/icons/square';
    import { createEventDispatcher } from 'svelte';
    const dispatch = createEventDispatcher();

    export let participants = [];

    // update this on response
    let selected_count = 0;
    let all_participants = false;

    function toggle_participant(id){
        let idx = participants.findIndex(participant => participant.id === id);
        if (idx > -1){
            let new_participants = participants;
            let new_state;
            if(participants[idx].state){
                selected_count -= 1;
                new_state = false;
            }else{
                selected_count += 1;
                new_state = true;
            }
            new_participants[idx].state = new_state;
            participants = new_participants;
            dispatch('message', {
			    state: new_state, id: new_participants[idx].id
		    });
        }
    }

    function toggle_all_participants(){
        if(all_participants){
            all_participants = false;
        }else{
            all_participants = true;
        }
    }

</script>

<div class="flex flex-col w-full h-full">
    <div class="flex flex-col">
        <div class="flex flex-row gap-1 shrink-0 h-12 bg-slate-700 justify-between px-4">
            <button class="flex my-auto"><Icon class="w-4 h-4 text-white" data={refresh}/></button>
            <button on:click={() => toggle_all_participants()} class="flex my-auto"><Icon class="w-4 h-4 text-white" data={all_participants ? checkSquare : square}/></button>
            <button class="flex my-auto"><Icon class="w-4 h-4 text-white rotate-180" data={sortAmountDesc}/></button>
            <button class="flex my-auto"><Icon class="w-4 h-4 text-white rotate-180" data={sortAmountAsc}/></button>
        </div>
        <div class="flex flex-col w-full bg-slate-500">
            <div class="flex justify-between p-2">
                <div class="flex gap-2">
                    <Icon class="w-6 h-6 text-slate-400" data={users}/>
                    <h1 class="text-slate-200 whitespace-nowrap">Participants: </h1>
                </div>
                <p class="text-white whitespace-nowrap">{selected_count} <span class="text-slate-400">of</span> {participants.length}</p>
            </div>
        </div>
    </div>
    <ul class="w-full overflow-auto">
    {#each participants as participant}
        <li class="w-full">
            <button class="flex justify-between align-middle my-1 p-2 w-full h-full text-left {participant.state ? 'text-blue-600 bg-slate-200' : 'text-slate-500'} border-b-2 border-neutral-100 border-opacity-100 dark:border-opacity-50" on:click={() => toggle_participant(participant.id)}>
                {participant.name}
                {#if participant.warning_label}
                    <Icon class="my-auto text-yellow-400" data={warning}/>
                {/if}
            </button>
        </li>
    {/each}
    </ul>
</div>