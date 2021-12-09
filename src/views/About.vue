<template>
<div class="about">
    <h1>This is an about page</h1>
    <ow-row class="row">
        <label>
            玩家 A 昵称
            <ow-input v-model="playerA"></ow-input>
        </label>
    </ow-row>
    <ow-row class="row">
        <label>
            玩家 B 昵称
            <ow-input v-model="playerB"></ow-input>
        </label>
    </ow-row>
    <ow-button type="primary" @click="toStartGame">start game</ow-button>

</div>
</template>

<script>
import { mapMutations } from "vuex"

export default {
    data() {
        return {
            playerA: "",
            playerB: ""
        }
    },
    methods: {
        toStartGame() {
            console.log("to start game")
            this.$store.state.playerName.a = this.playerA
            this.$store.state.playerName.b = this.playerB
            this.$router.push("game")
        }
    }
}
</script>
