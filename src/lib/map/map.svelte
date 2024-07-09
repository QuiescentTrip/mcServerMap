<script lang="ts">
	import mapfiles from './map-files.json';
	export let biome = 'overworld';
	export let layer = 'day';
	let mapImages = [];
	console.log(mapfiles);

	async function fetchMapImages(biome, layer) {
		let biomeJson = mapfiles[biome];
		let layerJson = biomeJson[layer];
		// Parse filenames to get coordinates
		mapImages = layerJson.map((file) => {
			const [x, y] = file.replace('.png', '').split(',').map(Number);
			return { x, y, src: `/map/${biome}/${layer}/${file}` };
		});
	}
	$: fetchMapImages(biome, layer);
	$: console.log(biome);
</script>

<div class="relative grid gap-0 row-span-full" style="grid-template-columns: repeat(auto-fill);">
	{#each mapImages as { x, y, src }}
		<div class="relative w-24 h-24" style="grid-row: {y - 1}; grid-column: {x - 1}">
			<img {src} alt={`Tile at (${x}, ${y})`} class="w-full h-full object-cover" />
		</div>
	{/each}
</div>
