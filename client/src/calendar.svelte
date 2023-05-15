<script>

    // let months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    let months = ['Jan', 'Feb', 'March', 'April', 'May', 'June', 'July', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    let days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    let day = 0;
    let month = 0;
    let year = 2023;
    let month_length = 31;
    let timeframe = 'Day';
    let active_button_style = 'bg-red-300 text-white'

    function get_days_in_month (month, year) {
        return new Date(parseInt(year), parseInt(month) + 1, 0).getDate();
    }

    function set_year(y){
        year = y;
    }

    function set_month(m){
        if(m < 0){
            m = 11;
            set_year(year - 1);
        }
        if(m > 11){
            m = 0;
            set_year(year + 1);
        }
        month = m;
        month_length = get_days_in_month(month, year); // update how many days in month
    }

    function set_day(d){
        if(d < 0){
            set_month(month - 1);
            d = month_length - 1;
        }
        if(d > month_length){
            set_month(month + 1);
            d = month_length - 1;
        }
        day = d;
    }

    function change_view(tf){
        timeframe = tf;
    }

</script>

<div class="flex flex-col w-full h-full grow-0">

    <!-- timeframe navigator -->
    <div class="shrink-0 w-full mx-auto flex flex-row justify-center overflow-clip align-middle bg-slate-700">
        <button on:click={() => change_view('Day')} class="transition-all {timeframe === 'Day' ? active_button_style : ''} py-2 text-white w-1/4">Day</button>
        <button on:click={() => change_view('Month')} class="transition-all {timeframe === 'Month' ? active_button_style : ''} py-2 text-white w-1/4">Month</button>
        <button on:click={() => change_view('Year')} class="transition-all {timeframe === 'Year' ? active_button_style : ''} py-2 text-white w-1/4">Year</button>
    </div>

    <!-- main calendar view -->
    {#if timeframe === 'Day'}
    <div class="shrink-0 w-full text-white mx-auto flex flex-row justify-center overflow-clip align-middle bg-slate-500">
        <button on:click={() => set_day(day - 1)} class="py-2 w-1/3">&#8592</button>
        <div class="py-2 w-1/3 text-center"><h1>{days[day % 7]}</h1></div>
        <button on:click={() => set_day(day + 1)} class="py-2 w-1/3">&#8594</button>
    </div>
    <div class="w-full h-full overflow-auto">
        {#each {length:24} as _, h}
            <div><button class="w-full text-left pl-4 text-slate-500 border-b-2 border-neutral-100 border-opacity-100 dark:border-opacity-50">{h < 10 ? '0' + h : '' + h}:00</button></div>
        {/each}
    </div>

    {:else if timeframe === 'Month'}
    <div class="w-full text-white mx-auto flex flex-row justify-center overflow-clip align-middle bg-slate-500">
        <button on:click={() => set_month(month - 1)} class="py-2 w-1/3">&#8592</button>
        <div class="py-2 w-1/3 text-center"><h1>{months[month]}</h1></div>
        <button on:click={() => set_month(month + 1)} class="py-2 w-1/3">&#8594</button>
    </div>
    <div class="flex-1 p-4">
        <div class="w-full h-full grid grid-cols-7">
            {#each {length:month_length} as _, d}
                <div><button on:click={() => set_day(d)} class="w-full h-full rounded-lg {d === day ? active_button_style : 'text-slate-500'}">{d + 1}</button></div>
            {/each}
            {#each {length:35 - month_length} as _, d}
                <div><button on:click={() => {set_month(month + 1); set_day(d)}} class="w-full h-full rounded-lg text-slate-300">{d + 1}</button></div>
            {/each}
        </div>
    </div>

    {:else if timeframe === 'Year'}
    <div class="w-full text-white mx-auto flex flex-row justify-center overflow-clip align-middle bg-slate-500">
        <button on:click={() => set_year(year - 1)} class="py-2 w-1/3">&#8592</button>
        <div class="py-2 w-1/3 text-center"><h1>{year}</h1></div>
        <button on:click={() => set_year(year + 1)} class="py-2 w-1/3">&#8594</button>
    </div>
    <div class="flex-1 p-4">
        <div class="w-full h-full grid grid-cols-4">
            {#each months as m, id}
                <div><button on:click={() => set_month(id)} class="w-full h-full rounded-lg {id === month ? active_button_style : 'text-slate-500'}">{m}</button></div>
            {/each}
        </div>
    </div>
    {/if}

</div>