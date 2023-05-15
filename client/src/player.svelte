<script>

    // NEXT UP
    // get transcription data and -128:128 audio wave data of 10 using pydub and audio to speech libs
    // add to schema.sql and re-init
    // add transcription representation on here
    // finally push to git (remove debug metrics and --debug command line args) and host on repl

    import { onMount } from 'svelte';
    import { Icon } from 'svelte-awesome';
    import play from 'svelte-awesome/icons/play';
    import pause from 'svelte-awesome/icons/pause';
    import fastForward from 'svelte-awesome/icons/fastForward';
    import fastBackward from 'svelte-awesome/icons/fastBackward';
    import stepBackward from 'svelte-awesome/icons/stepBackward';
    import stepForward from 'svelte-awesome/icons/stepForward';
    import thList from 'svelte-awesome/icons/thList';
    import searchPlus from 'svelte-awesome/icons/searchPlus';
    import searchMinus from 'svelte-awesome/icons/searchMinus';

    // this will be pulled from flask eventually
    import BigBuckBunny from "./movies/BigBuckBunny.json";
    import ElephantsDream from "./movies/ElephantsDream.json";
    import ForBiggerBlazes from "./movies/ForBiggerBlazes.json";
    import ForBiggerEscapes from "./movies/ForBiggerEscapes.json";
    import ForBiggerFun from "./movies/ForBiggerFun.json";
    import ForBiggerJoyrides from "./movies/ForBiggerJoyrides.json";
    import ForBiggerMeltdowns from "./movies/ForBiggerMeltdowns.json";
    import Sintel from "./movies/Sintel.json";
    import SubaruOutbackOnStreetAndDirt from "./movies/SubaruOutbackOnStreetAndDirt.json";
    import TearsOfSteel from "./movies/TearsOfSteel.json";

    export let videos = [];
    let name = "";
	let source = "";
    let time = 0;
	let duration = 0;
	let paused = true;
    let fps = 0;
    let mplayer;
    let current_video_index = 0;

    function select_video(id){
        let idx = videos.findIndex(video => video.id === id);
        if (idx > -1){
            name = videos[idx].name;
            source = videos[idx].source;
            fps = videos[idx].fps;
            duration = videos[idx].duration;
            current_video_index = idx;
            time = 0;
            paused = true;
            draw_canvas();
        }
    }

    function toggle_play(){
        if(paused){
            paused = false;
        }else{
            paused = true;
        }
    }

    function seek(sec){
        if (time + sec < duration){
            time += sec;
        }else if(time + sec < 0){
            time = 0;
        }else{
            time = duration;
            paused = true;
        }
    }

    function step_frame(frames = 0){
        if(!paused) paused = true;
        time += (1.0 / fps) * frames;
        if (time > duration){
            time = duration;
        }
        if (time < 0){
            time = 0;
        }
    }

    let playlist = false;
    function toggle_playlist(){
        playlist = !playlist;
    }

    let mouse_x = 0;
    function mouseHover(e){
        const {left, right} = this.getBoundingClientRect();
        mouse_x = (e.clientX - left) / (right - left) * canvas_w;
    }

    function mouseLeave(){
        mouse_x = -1;
    }

    function seekOffset(){
        // transform x from [0:canvas_w] to [0:duration]
        time = mouse_x / 10;
    }

    let canvas;
    let canvas_w = 1024 * 10;
    let canvas_h = 192;
    let ctx;

    function draw_canvas(){

        let audio;
    
        // THIS IS BRAINDEAD BUT IS OKAY FOR DEMO APPS
        switch(name){
            case "BigBuckBunny":
                audio = BigBuckBunny.samples;
                break;
            case "ElephantsDream":
                audio = ElephantsDream.samples;
                break;
            case "ForBiggerBlazes":
                audio = ForBiggerBlazes.samples;
                break;
            case "ForBiggerEscapes":
                audio = ForBiggerEscapes.samples;
                break;
            case "ForBiggerFun":
                audio = ForBiggerFun.samples;
                break;
            case "ForBiggerJoyrides":
                audio = ForBiggerJoyrides.samples;
                break;
            case "ForBiggerMeltdowns":
                audio = ForBiggerMeltdowns.samples;
                break;
            case "Sintel":
                audio = Sintel.samples;
                break;
            case "SubaruOutbackOnStreetAndDirt":
                audio = SubaruOutbackOnStreetAndDirt.samples;
                break;
            case "TearsOfSteel":
                audio = TearsOfSteel.samples;
                break;
        }

        ctx.clearRect(0, 0, canvas.width, canvas.height);

        let bar_w = (duration * 10) / audio.length;
        let bar_offset = 0;

        for (let bar = 0; bar < audio.length; bar++){
            ctx.strokeStyle = `rgb( ${Math.floor((bar_offset / canvas_w) * 50)}, ${Math.floor((bar_offset / canvas_w) * 128)}, ${Math.floor(audio[bar]) % 255})`;
            ctx.beginPath();
            if (audio[bar] === 0) {
                // draw horizontal line if no sound
                ctx.moveTo(bar_offset, canvas_h / 2 - 1);
                ctx.lineTo(bar_offset, canvas_h / 2 + 1);
            }else{
                // else draw line from middle to audio[bar]
                ctx.moveTo(bar_offset, canvas_h / 2);
                ctx.lineTo(bar_offset, (audio[bar] / 1000) * 128 + canvas_h / 2);
            }
            ctx.stroke();
            bar_offset += bar_w;
        }
    }

    onMount(() => {
        ctx = canvas.getContext('2d');
    })

</script>

<div class="flex w-full h-full">
    <!-- player -->
    <div class="flex flex-col w-full overflow-auto">

        <!-- playback controls -->
        <div class="w-full h-8 flex flex-row shrink-0 gap-1 bg-slate-700">
            <button on:click={() => seek(-5)} class="flex py-2 text-slate-50 w-8"><Icon class="m-auto" data={fastBackward}/></button>
            <button on:click={() => step_frame(-1)} class="flex py-2 text-slate-50 w-8"><Icon class="m-auto" data={stepBackward}/></button>
            <button on:click={toggle_play} class="flex py-2 text-slate-50 w-8"><Icon class="m-auto" data={paused ? play : pause}/></button>
            <button on:click={() => step_frame(1)} class="flex py-2 text-slate-50 w-8"><Icon class="m-auto" data={stepForward}/></button>
            <button on:click={() => seek(5)} class="flex py-2 text-slate-50 w-8"><Icon class="m-auto" data={fastForward}/></button>
            <div class="grow"></div>
            <button class="flex py-2 text-slate-50 w-8"><Icon class="m-auto" data={searchPlus}/></button>
            <button class="flex py-2 text-slate-50 w-8"><Icon class="m-auto" data={searchMinus}/></button>
            <button on:click={() => toggle_playlist()} class="flex py-2 text-slate-50 w-8"><Icon class="m-auto" data={thList}/></button>
        </div>

        {#key source}
        <!-- video -->
        <div class="grow bg-black">
            <video
                class="h-full"
                bind:this={mplayer}
                bind:currentTime={time}
                bind:paused>
	            <source type="video/mp4" src="{source}">
                <track kind="captions">
            </video>
        </div>
        {/key}

        <!-- transcripts, audio waves -->
        <div class="flex w-full relative basis-48 bg-slate-300 overflow-auto">
            <!-- waves -->
            <canvas bind:this={canvas} width={canvas_w} height={canvas_h}></canvas>
            <!-- timestamps -->
            <svg class="absolute left-0 top-0 bg-slate-800" width={canvas_w} height={20}>
                <!-- second bars -->
                {#each {length:canvas_w / 8} as _, i}
                    <line class="stroke-slate-300" stroke-width="0.5" x1="{10 * i}" x2="{10 * i}" y1="0" y2="20"/>
                {/each}
                <!-- minute bars -->
                {#each {length:canvas_w / 64} as _, i}
                    <line class="stroke-slate-300" stroke-width="2" x1="{100 * i}" x2="{100 * i}" y1="0" y2="20"/>
                    <text class="fill-slate-400 text-sm" stroke-width="0" x="{100 * i + 1}" y="15">{Math.floor(i / 6) < 10 ? '0' : ''}{Math.floor(i / 6)}:{i % 6}0</text>
                {/each}
            </svg>
            <!-- carets -->
            <svg class="absolute left-0 top-0" width={canvas_w} height={canvas_h}
                on:mouseenter={mouseHover}
                on:mousemove={mouseHover}
                on:mousedown={seekOffset}
                on:mouseleave={mouseLeave}>
                <!-- caret at mouse x -->
                <line x1="{mouse_x}" y1="0" x2="{mouse_x}" y2="{canvas_h}" class="stroke-red-500" stroke-width="2"/>
                <!-- caret at current time -->
                <line x1="{time * 10}" y1="0" x2="{time * 10}" y2="{canvas_h}" class="stroke-red-500" stroke-width="2"/>
            </svg>
        </div>
    </div>

    <!-- playlist -->
    {#if playlist}
    <div class="overflow-auto w-64">
        <ul class="w-full h-full overflow-auto bg-slate-700">
            {#each videos as video, i}
                <li class="overflow-x-scroll w-full {current_video_index === i ? 'bg-red-400' : ''} ">
                    <button class="my-1 p-2 overflow-x-hidden" on:click={() => select_video(video.id)}>
                        <p class="text-slate-300 whitespace-nowrap">[{i + 1}] {video.name}</p>
                    </button>
                </li>
            {/each}
        </ul>
    </div>
    {/if}
</div>