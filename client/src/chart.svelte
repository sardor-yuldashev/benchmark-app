<script>
    import Chart from 'svelte-frappe-charts';
    import {onMount} from 'svelte'

    let chart_height;
    let render_chart = false;
    let data = {
        labels: ['Sun', 'Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat'],
        datasets: [
            {
                name: "videos",
                values: [10, 12, 3, 9, 8, 15, 9]
            },
            {
                name: "est. gross",
                values: [30, 50, -10, 15, 18, 32, 27],
            },
            {
                name: "energy usage",
                values: [100, 110, 90, 0, 105, 32, 110],
            }
        ]
    };

    onMount(() => {
        render_chart = true;
        console.log(chart_height);
    });

</script>

<div class="w-full h-full" bind:clientHeight={chart_height}>
    {#if render_chart}
        <Chart height={chart_height} data={data} type="line" />
    {/if}
</div>