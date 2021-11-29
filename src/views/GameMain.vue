<template>
<ow-layout class="layout">
    <ow-header class="header">Header</ow-header>
    <ow-layout>
        <ow-content class="content">
            <ow-row class="row">
                <ow-col :pc="{span: 8}">
                    player A
                    <ow-hero hero="mccree"></ow-hero>
                    <ow-blood residualColor="#3B9CE1" goneColor="#909399" :total="150" :residual="50"></ow-blood>
                    <ow-button type="primary">primary</ow-button>
                    <div v-bind:class="(item.hovered==true)?'box foo-hover':'box'" v-for="(item, idx) in playerAcards" :key="item.cid" @mouseover="item.hovered = true" @mouseleave="item.hovered = false" @click="selectCard(item)">
                        <div v-if="item.hovered==true">
                            idx: {{idx}}
                            {{typeof(item.cid)}} element: {{item.element}}
                            Hover to Show Secret
                        </div>
                        <p v-if="!item.hovered">Secret !!!</p>
                    </div>
                </ow-col>
                <ow-col :pc="{span: 8}">
                    game info
                </ow-col>
                <ow-col :pc="{span: 8}">
                    player B

                    <div class="col-item col-item-primary"></div>
                    <ow-hero hero="mccree"></ow-hero>

                    <ow-blood residualColor="#3B9CE1" goneColor="#909399" :total="150" :residual="50"></ow-blood>
                    <ow-button type="primary">primary</ow-button>

                </ow-col>

            </ow-row>
        </ow-content>
    </ow-layout>
    <ow-footer class="footer">Footer</ow-footer>
</ow-layout>
</template>

<script>
export default {
  data () {
    return {
      selected: '0',
      playerAcards: [],
      playerBcards: [],
      playerA: {
        name: 'player A',
        score: 150
      },
      playerB: {
        name: 'player B',
        score: 150
      }
    }
  },
  methods: {
    intiGame () {
      const that = this
      var playerAcards = []
      var playerBcards = []
      var cardNo = 0
      //   init player Score card
      for (cardNo = 0; cardNo < 4; cardNo++) {
        playerAcards.push({
          cid: cardNo.toString(),
          element: 'something',
          hovered: false
        })
        playerBcards.push({
          cid: cardNo.toString(),
          element: 'something B',
          hovered: false
        })
      }
      that.playerAcards = playerAcards
      that.playerBcards = playerBcards
      console.log(that.playerAcards)
    },
    selectCard (card) {
      console.log('select card', card.cid)
    }
  },
  created () {
    this.intiGame()
  }
}
</script>

<style scoped>
.box {
    border: 1p solid;
    border-color: black;
    padding: 5px;
    margin: 5px;
    width: 100px;
    height: 160px;
    background-color: bisque;
}

.foo-hover {
    background-color: greenyellow;
}
</style>
