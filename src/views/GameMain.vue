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
                    <div v-bind:class="(item.hovered==true)?'box foo-hover':'box'" v-for="(item, idx) in players[0].cards" :key="idx" @mouseover="item.hovered = true" @mouseleave="item.hovered = false" @click="selectCard(item, 0, idx)">
                        <div v-if="item.hovered==true">
                            idx: {{idx}}
                            {{typeof(item.cid)}} element: {{item.element}}
                            Hover to Show Secret
                        </div>
                        <p v-if="!item.hovered">Secret !!!</p>
                    </div>
                    <div v-if="currPlayer === 0 && cardSelected == 1">
                        <ow-button type="primary" @click="toAction(0, 1)">加入对方烧杯</ow-button>
                        <ow-button type="warning" @click="toAction(0, 0)">加入已方烧杯</ow-button>
                        <!-- <ow-button type="info">Info</ow-button>
                        <ow-button type="danger">Danger</ow-button> -->
                    </div>
                </ow-col>
                <ow-col :pc="{span: 8}" class="centerBox">
                    game info
                    <div>当前玩家 {{players[currPlayer].name}}</div>
                    <div>
                        {{players[currPlayer].cards[currCardId]}}
                    </div>
                    <div style="border: 2px solid black;" v-if="currAction !== ''">
                        {{currAction}}
                    </div>
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
      currCardId: null,
      selected: '0',
      currPlayer: 0,
      cardSelected: 0,
      players: [{
        name: 'player A',
        score: 150,
        cards: []
      },
      {
        name: 'player B',
        score: 150,
        cards: []
      }
      ],
      currAction: ''
    }
  },
  methods: {
    intiGame () {
      const that = this
      var cardNo = 0
      var players = that.players
      //   init player Score card
      for (cardNo = 0; cardNo < 4; cardNo++) {
        players[0].cards.push({
          cid: cardNo.toString(),
          element: 'something',
          hovered: false
        })
        players[1].cards.push({
          cid: cardNo.toString(),
          element: 'something B',
          hovered: false
        })
      }
      that.players = players
    },
    initPlayer () {
      console.log('init player')
    },
    selectCard (card, playerId, currCardId) {
      const that = this
      console.log('select card', playerId, currCardId)
      that.cardSelected = 1
      that.currCardId = currCardId
    },
    toAction (playerId, tubeId) {
      const that = this
      var currPlayer = that.currPlayer
      var currCardId = that.currCardId
      console.log('player ', this.players[playerId].name, '将', this.players[currPlayer].cards[currCardId].element, '加入', this.players[tubeId].name, '烧杯')
      var currAction = ['player ', this.players[playerId].name, '将', this.players[currPlayer].cards[currCardId].element, '加入', this.players[tubeId].name, '烧杯'].join(' ')
      that.currAction = currAction
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

.centerBox {
    border: 1p solid;
    border-color: black;
    padding: 5px;
    background-color: lightgoldenrodyellow;
}
</style>
