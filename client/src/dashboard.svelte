<script>

    import Calendar from "./calendar.svelte";
    import Chart from "./chart.svelte";
    import Stations from "./stations.svelte";

    let runtime = 1649;     // HH:MM:SS
    let processed = 432;    // number of participants processed or was made
    let est_gross = 44700;  // estimated profit
    let est_kwh = 1101;     // estimated energy usage

</script>

<!-- main container -->
<!-- min-h-0 allow grid cell's content to be bigger than cell's size -->
<div class="p-2 w-full h-full grid grid-rows-4 grid-cols-4 grid-flow-col gap-2 min-h-0">

    <!-- basic stats -->
    <div class="col-span-3 row-span-1 border-2 border-slate-200 p-4">
        <div class="flex flex-none flex-nowrap h-full justify-between items-center whitespace-nowrap">
            <div class="w-1/4">
                <h1 class="text-slate-400">Runtime</h1>
                <h3 class="text-slate-600 text-2xl">{runtime}</h3>
                <p class="text-green-400">+36.04%</p>
            </div>
            <div class="w-1/4">
                <h1 class="text-slate-400">Processed</h1>
                <h3 class="text-slate-600 text-2xl">{processed}</h3>
                <p class="text-green-400">+55.09%</p>
            </div>
            <div class="w-1/4">
                <h1 class="text-slate-400">Est. gross</h1>
                <h3 class="text-slate-600 text-2xl">{est_gross}</h3>
                <p class="text-green-400">+12.06%</p>
            </div>
            <div class="w-1/4">
                <h1 class="text-slate-400">Energy usage</h1>
                <h3 class="text-slate-600 text-2xl">{est_kwh} Kwh</h3>
                <p class="text-red-400">-05.93%</p>
            </div>
        </div>
    </div>

    <!-- main chart -->
    <div class="col-span-3 row-span-3 border-2 border-slate-200">
        <Chart/>
    </div>

    <!-- calendar -->
    <div class="col-span-1 row-span-2 border-2 border-slate-200 overflow-auto">
        <Calendar/>
    </div>

    <!-- left pane -->
    <div class="col-span-1 row-span-2 border-2 border-slate-200 overflow-auto">
        <Stations/>
    </div>

</div>