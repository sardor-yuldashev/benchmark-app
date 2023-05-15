<script>

    // icons
    import Icon from 'svelte-awesome';
    import bars from 'svelte-awesome/icons/bars';
    import home from 'svelte-awesome/icons/home';
    import desktop from 'svelte-awesome/icons/desktop';
    import close from 'svelte-awesome/icons/close';

    import Dashboard from "./dashboard.svelte";
    import Benchmark from "./benchmark.svelte";

    let menu = false;
    let currentTabId = 0;
    let newTabId = 0;
    let tabs = [];

    function toggle_menu(){
        menu = !menu;
    }

    function select_tab(tabId){
        currentTabId = tabId;
    }

    function push_tab(tab){
        tabs = [...tabs, tab];
        select_tab(tab.id);
        newTabId = newTabId + 1;
    }

    function pop_tab(tabId){
        let idx = tabs.findIndex(tab => tab.id === tabId);
        let new_tabs = tabs.filter((tab) => tab.id !== tabId);
        tabs = new_tabs;
        newTabId = tabs.length === 0 ? 0 : newTabId;
    }

</script>

<div class="w-screen h-screen">

    <!-- sidebar -->
    <div class="z-50 fixed top-0 left-0 h-full bg-white transition-all border-r-2 border-slate-200 {menu ? 'w-48' : 'w-12'} overflow-clip">

        <!-- menu toggle -->
        <div class="p-2">
            <button on:click={toggle_menu} class="flex w-8 h-8 {menu ? 'bg-slate-200' : ''} rounded-lg">
                <Icon class="m-auto h-6 w-6 text-slate-700" data={bars}/>
            </button>
        </div>

        <!-- dashboard -->
        <button class="flex" on:click={() => push_tab({id:newTabId, componentId:0, title:'Dashboard' + newTabId})}>
            <div class="w-12 h-12 flex align-middle justify-center"><Icon class="my-auto h-8 w-8 text-slate-700" data={home}/></div>
            <div class="flex w-36 h-12 items-center"><p>Dashboard</p></div>
        </button>

        <!-- benchmark -->
        <button class="flex" on:click={() => push_tab({id:newTabId, componentId:1, title:'Benchmark' + newTabId})}>
            <div class="w-12 h-12 flex align-middle justify-center"><Icon class="my-auto h-8 w-8 text-slate-700" data={desktop}/></div>
            <div class="flex w-36 h-12 items-center"><p>Benchmark</p></div>
        </button>

    </div>

    <!-- main -->
    <div class="pl-12 flex flex-col h-full w-full">

        <!-- tab bar -->
        <div class="shrink-0 flex h-12 w-full overflow-auto bg-slate-100">
            {#each tabs as tab}
            <button class="flex shrink-0 w-56 h-12 text-left px-4 items-center justify-between {currentTabId === tab.id ? 'bg-white' : ''}" on:click={() => select_tab(tab.id)}>
                <p>{tab.title}</p>
                <button class="flex h-6 w-6 rounded-lg hover:bg-slate-200" on:click={() => pop_tab(tab.id)}>
                    <Icon class="m-auto h-4 w-4 text-slate-700" data={close}/>
                </button>
            </button>
            {/each}
        </div>

        <!-- tab content -->
        {#each tabs as tab}
            {#if tab.componentId === 0 && tab.id === currentTabId}
                <Dashboard/>
            {:else if tab.componentId === 1 && tab.id === currentTabId}
                <Benchmark/>
            {/if}
        {/each}

    </div>

</div>