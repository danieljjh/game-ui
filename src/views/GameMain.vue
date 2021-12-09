<template>
<ow-layout class="layout">
    <ow-header class="header">Header</ow-header>
    <ow-layout>
        <ow-content class="content">
            <ow-row class="row">
                <ow-col :pc="{span: 8}">
                    {{players[0].name}}
                    <ow-hero hero="mccree"></ow-hero>
                    <ow-blood residualColor="#3B9CE1" goneColor="#909399" :total="150" :residual="120"></ow-blood>
                    <div>
                        <img src="@/assets/beaker.png" class="beaker" @mouseover="showBeakerA=true" @mouseleave="showBeakerA=false" @click="putBeakerA" />
                    </div>
                    <div v-if="showBeakerA==true">点击放入这里</div>
                    <ow-row class="row cards" v-if="currPlayer===0">
                        <div v-bind:class="(item.hovered==true)?'box foo-hover':'box'" v-for="(item, idx) in players[0].cards.slice(0, 4)" :key="idx" @mouseover="item.hovered = true" @mouseleave="item.hovered = false" @click="selectCard(item, 0, idx)">
                            <div v-if="item.hovered==true">
                                idx: {{idx}}
                                {{typeof(item.cid)}} element: {{item.element}}
                                Hover to Show Secret
                            </div>
                            <p v-if="!item.hovered">Secret !!!</p>
                        </div>
                    </ow-row>

                    <div v-if="currPlayer === 0 && cardSelected == 1">
                        <ow-button type="primary" @click="toAction(0, 1)">加入对方烧杯</ow-button>
                        <ow-button type="warning" @click="toAction(0, 0)">加入已方烧杯</ow-button>
                        <ow-button type="danger" @click="toQuit(0)">结束游戏</ow-button>
                    </div>
                </ow-col>
                <!-- 游戏通告 -->
                <ow-col :pc="{span: 8}" class="centerBox">
                    game info
                    <h2>当前回合 {{currentRound}}</h2>
                    <div>当前玩家 {{players[currPlayer].name}}</div>
                    <div style="color: red">
                        已选择 {{players[currPlayer].cards[currCardId]}}
                    </div>

                    <ow-modal :is-fixed="false" :is-open.sync="isOpen" class="modal">
                        <template slot="header">
                            {{currAction}}
                        </template>
                        <p style="margin-bottom: 12px">PUT A GAME ID OR EMAIL ADDRESS</p>

                    </ow-modal>
                    <div style="border: 2px solid black;" v-if="currAction !== ''">
                        <div v-for="(item, idx) in actionLog" :key="idx">
                            {{idx}}: {{item}}
                        </div>
                    </div>
                </ow-col>
                <ow-col :pc="{span: 8}">
                    {{players[1].name}}
                    <div class="col-item col-item-primary"></div>
                    <ow-hero hero="mccree"></ow-hero>
                    <ow-blood residualColor="#3B9CE1" goneColor="#909399" :total="150" :residual="50"></ow-blood>
                    <div>
                        <img src="@/assets/beaker.png" class="beaker" @mouseover="showBeakerB=true" @click="putBeakerB" @mouseleave="showBeakerB=false"/>
                        <div v-if="showBeakerB==true">点击放入这里</div>

                    </div>
                    <ow-row class="row cards " v-if="currPlayer===1">
                        <div v-bind:class="(item.hovered==true)?'box foo-hover  ':'box' " v-for="(item, idx) in players[1].cards.slice(0, 4)" :key="idx" @mouseover="item.hovered = true" @mouseleave="item.hovered = false" @click="selectCard(item, 0, idx)">
                            <div v-if="item.hovered==true">
                                idx: {{idx}}
                                {{typeof(item.cid)}} element: {{item.element}}
                                Hover to Show Secret
                            </div>
                            <p v-if="!item.hovered">Secret !!!</p>
                        </div>
                    </ow-row>

                    <div v-if="currPlayer === 1 && cardSelected == 1">
                        <ow-button type="primary" @click="toAction(1, 1)">加入对方烧杯</ow-button>
                        <ow-button type="warning" @click="toAction(1, 0)">加入已方烧杯</ow-button>
                        <ow-button type="danger" @click="toQuit(1)">结束游戏</ow-button>
                    </div>

                </ow-col>

            </ow-row>
        </ow-content>
    </ow-layout>
    <ow-footer class="footer">Footer</ow-footer>
</ow-layout>
</template>

<script>
export default {
    data() {
        return {
            showBeakerA: false,
            showBeakerB: false,
            gameOver: false,
            isOpen: false,
            currCardId: null,
            selected: "0",
            currentRound: 1,
            currPlayer: 0,
            cardSelected: 0,
            players: [{
                    name: "player A",
                    score: 150,
                    cards: [],
                    credit: 100,
                    phValue: 7,
                    water: 100
                },
                {
                    name: "player B",
                    score: 150,
                    cards: [],
                    credit: 100,
                    phValue: 7,
                    water: 100
                }
            ],
            currAction: "",
            actionLog: []
        }
    },
    methods: {
        /**
         *  初始化游戏
         */
        intiGame() {
            const that = this
            var cardNo = 8
            var players = that.players
            //   init player Score card
            for (cardNo = 0; cardNo < 8; cardNo++) {
                players[0].cards.push({
                    cid: cardNo.toString(),
                    element: "something",
                    cardCredit: 3,
                    hovered: false
                })
                players[1].cards.push({
                    cid: cardNo.toString(),
                    element: "something B",
                    cardCredit: 3,
                    hovered: false
                })
            }
            that.players = players
        },
        initPlayer() {
            console.log("init player")
            var playerA = this.$store.getters.getPlayerName("a")
            var playerB = this.$store.getters.getPlayerName("b")
            console.log("player A", playerA, playerB)
            console.log("player names", this.$store.state.playerName)
            this.players[0].name = playerA
            this.players[1].name = playerB
        },
        selectCard(card, playerId, currCardId) {
            const that = this
            console.log("select card", playerId, currCardId)
            that.cardSelected = 1
            that.currCardId = currCardId
        },
        putBeakerA() {
            const that = this
            var currPlayer = that.currPlayer
            var currCardId = that.currCardId
            console.log("put card to beakerA", this.players[currPlayer].cards[currCardId].element)
        },
        putBeakerB() {
            const that = this
            var currPlayer = that.currPlayer
            var currCardId = that.currCardId
            console.log("put card to beakerB", this.players[currPlayer].cards[currCardId].element)
        },
        /**
         *  玩家动作
         */
        toAction(playerId, tubeId) {
            const that = this
            var currPlayer = that.currPlayer
            var currCardId = that.currCardId
            console.log(this.players[playerId].name, "将", this.players[currPlayer].cards[currCardId].element, "加入", this.players[tubeId].name, "烧杯")
            var currAction = [this.players[playerId].name, "将", this.players[currPlayer].cards[currCardId].element, "加入", this.players[tubeId].name, "烧杯"].join(" ")
            that.currAction = currAction
            that.actionLog.push(currAction)
            // console.log(that.actionLog)
            /**
             * to send action and get result
             */
            console.log("(playerId + 1)", (playerId + 1) % 2)
            var nxtPlayer = (playerId + 1) % 2 === 0 ? 0 : 1
            // reset states
            that.isOpen = true
            that.cardSelected = 0
            that.currPlayer = nxtPlayer
            that.currentRound += 1
            // setTimeout(function () {
            //     that.isOpen = false
            // }, 4000)
        }
    },
    toQuit(playerId) {
        var that = this
        var player = that.player[playerId]
        that.currAction = player.name + " 放弃了游戏"
        that.isOpen = true
        that.gameOver = true
    },
    created() {
        console.log("")
        this.initPlayer()
        this.intiGame()
    },
    computed: {},
    watch: {
        currentRound: function () {
            if (this.currentRound > 4) {
                console.log("to stop")
            }
        }
    }
}
</script>

<style scoped>
.box {
    border: 1p solid;
    border-color: black;
    /* padding: 5px; */
    width: 100px;
    height: 160px;
    background-color: bisque;
    margin-left: auto;
    margin-right: auto
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

.box-right {
    text-align: right;
    float: right;
}

.cards {
    padding-top: 100px;
    padding-bottom: 20px;
}

.beaker {
    padding-top: 50px;
    width: 200px;
}

.modal {
    width: 70%;
    background-color: transparent;
    margin-left: auto;
    margin-right: auto
}
</style>
