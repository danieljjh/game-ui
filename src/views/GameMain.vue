<template>
<ow-layout class="layout">
    <ow-header class="header">
        <h1>化学魔法 🪄 竞技场</h1>
    </ow-header>
    <ow-layout>
        <ow-content class="content">
            <ow-row class="row">
                <!-- 玩家1 -->
                <ow-col :pc="{span: 8}">
                    <ow-hero hero="mccree"></ow-hero>
                    <ow-blood totalTextColor="#FFC429" residualTextColor="#909399" residualColor="#3B9CE1" goneColor="#909399" :total="150" :residual="120"></ow-blood>
                    <ow-row class="row">
                        <ow-content class="content heroName">
                            {{players[0].name}}
                        </ow-content>
                    </ow-row>
                    <div>
                        <img src="@/assets/beaker.png" class="beaker" @mouseover="showBeakerA=true" @mouseleave="showBeakerA=false" @click="putBeakerA" />
                    </div>
                    <div v-if="showBeakerA==true">点击放入这里</div>
                    <div>
                        <div class="playerNotice" v-if="currPlayer===0">
                            <div>
                                请选择卡牌
                            </div>
                        </div>
                    </div>

                    <ow-row class="row cards" v-if="currPlayer===90">
                        <div v-bind:class="(item.hovered==true || (currPlayer==0 && currCardId==idx))?'box foo-hover':'box'" v-for="(item, idx) in players[0].cards.slice(0, 4)" :key="idx" @mouseover="item.hovered = true" @mouseleave="item.hovered = false" @click="selectCard(item, 0, idx)">
                            <div v-bind:class="(currPlayer==0 && currCardId==idx)? 'foo-selected': ''">
                                <div v-if="item.hovered==true || (currPlayer==0 && currCardId==idx)">
                                    idx: {{idx}}
                                    {{typeof(item.cid)}} element: {{item.element}}
                                    Hover to Show Secret
                                </div>
                                <p v-if="!item.hovered">Secret !!!</p>
                            </div>
                        </div>
                        <div v-if="currPlayer === 0 ">
                            <!-- <ow-button type="primary" @click="toAction(0, 1)">加入对方烧杯</ow-button>
                        <ow-button type="warning" @click="toAction(0, 0)">加入已方烧杯</ow-button> -->
                            <ow-button type="danger" @click="toEndRound(0)">结束回合</ow-button>
                            <ow-button type="danger" @click="toQuit(0)">结束游戏</ow-button>
                        </div>
                    </ow-row>

                </ow-col>
                <!-- 游戏通告 -->
                <ow-col :pc="{span: 8}" class="centerBox">
                    <h2>当前回合 {{currentRound}}</h2>
                    <div>当前玩家 {{players[currPlayer].name}}</div>
                    <div style="color: red">
                        已选择 {{players[currPlayer].cards[currCardId]}}
                    </div>

                    <ow-modal :is-fixed="false" :is-open.sync="isOpen" class="modal">
                        <template slot="header">
                            {{currAction}}
                        </template>
                        <p style="margin-bottom: 12px">发生了 xxx 化学反应</p>

                    </ow-modal>
                    <h3>互动历史</h3>
                    <ow-scroll style="border: 4px solid red;" :height="360">
                        <div style="border: 2px solid black;" v-if="currAction !== ''">
                            <div v-for="(item, idx) in actionLog" :key="idx">
                                {{idx}}: {{item}}
                            </div>
                        </div>
                    </ow-scroll>

                </ow-col>
                <!-- 玩家2 -->
                <ow-col :pc="{span: 8}">
                    <div class="col-item col-item-primary"></div>
                    <ow-hero hero="mccree"></ow-hero>
                    <ow-blood totalTextColor="#FFC429" residualTextColor="#909399" residualColor="#3B9CE1" goneColor="#909399" :total="150" :residual="50"></ow-blood>
                    <ow-row class="row">
                        <ow-content class="content heroName">
                            {{players[1].name}}
                        </ow-content>

                    </ow-row>
                    <div>
                        <img src="@/assets/beaker.png" class="beaker" @mouseover="showBeakerB=true" @click="putBeakerB" @mouseleave="showBeakerB=false" />
                        <div v-if="showBeakerB==true">点击放入这里</div>

                    </div>
                    <div v-if="currPlayer===1" style="text-align:center">
                        <div class="playerNotice">
                            请选择卡牌
                        </div>
                    </div>
                    <ow-row class="row cards " v-if="currPlayer===91">
                        <div v-bind:class="(item.hovered==true || (currPlayer==1 && currCardId==idx))?'box foo-hover  ':'box' " v-for="(item, idx) in players[1].cards.slice(0, 4)" :key="idx" @mouseover="item.hovered = true" @mouseleave="item.hovered = false" @click="selectCard(item, 0, idx)">
                            <div v-if="item.hovered==true || (currPlayer==1 && currCardId==idx)">
                                idx: {{idx}}
                                {{typeof(item.cid)}} element: {{item.element}}
                                Hover to Show Secret
                            </div>
                            <p v-if="!item.hovered">Secret !!!</p>
                        </div>

                        <div v-if="currPlayer === 1">
                            <!-- <ow-button type="primary" @click="toAction(1, 1)">加入对方烧杯</ow-button>
                        <ow-button type="warning" @click="toAction(1, 0)">加入已方烧杯</ow-button> -->
                            <ow-button type="danger" @click="toEndRound(1)">结束回合</ow-button>
                            <ow-button type="danger" @click="toQuit(1)">结束游戏</ow-button>
                        </div>
                    </ow-row>

                </ow-col>

            </ow-row>
        </ow-content>
    </ow-layout>
    <ow-footer class="footer">
        <ow-row class="row cards" v-if="currPlayer===0">
            <div v-bind:class="(item.hovered==true || (currPlayer==0 && currCardId==idx))?'box foo-hover':'box'" v-for="(item, idx) in players[0].cards.slice(0, 4)" :key="idx" @mouseover="item.hovered = true" @mouseleave="item.hovered = false" @click="selectCard(item, 0, idx)">
                <ow-popover trigger="hover" class="popover" position="top">
                    <div v-bind:class="(currPlayer==0 && currCardId==idx)? 'foo-selected': ''">
                        <div v-if="item.hovered==true || (currPlayer==0 && currCardId==idx)">
                            idx: {{idx}}
                            {{typeof(item.cid)}} element: {{item.element}}
                            Hover to Show Secret
                        </div>
                        <p v-if="!item.hovered">Secret !!! {{idx}}</p>
                    </div>
                    <template slot="content">
                        <div>点击选择这张牌，放进烧杯？</div>

                    </template>

                </ow-popover>
            </div>
            <!-- 第 5 张牌 -->
            <div v-bind:class="(item.hovered==true )?'box foo-hover  ':'box2' " v-for="(item) in players[0].cards.slice(4, 5)" :key="item.cid" @mouseover="item.hovered = true" @mouseleave="item.hovered = false">
                <ow-popover class="popover" position="top">
                    <div v-if="item.hovered==true ">
                        {{item.cid}}
                        {{typeof(item.cid)}} element: {{item.element}}
                        Hover to Show Secret
                    </div>
                    <p v-if="!item.hovered">Secret !!! {{item.cid}}</p>
                    <template slot="content">
                        <div>只能选择前 4 张牌</div>
                    </template>

                </ow-popover>
            </div>

        </ow-row>
        <div v-if="currPlayer === 0 ">
            <!-- <ow-button type="primary" @click="toAction(0, 1)">加入对方烧杯</ow-button>
                        <ow-button type="warning" @click="toAction(0, 0)">加入已方烧杯</ow-button> -->
            <ow-button type="danger" @click="toEndRound(0)">结束回合</ow-button>
            <ow-button type="danger" @click="toQuit(0)">结束游戏</ow-button>
        </div>
        <ow-row class="row cards " v-if="currPlayer===1">
            <div v-bind:class="(item.hovered==true || (currPlayer==1 && currCardId==idx))?'box foo-hover  ':'box' " v-for="(item, idx) in players[1].cards.slice(0, 4)" :key="idx" @mouseover="item.hovered = true" @mouseleave="item.hovered = false" @click="selectCard(item, 0, idx)">
                <div v-if="item.hovered==true || (currPlayer==1 && currCardId==idx)">
                    idx: {{idx}}
                    {{typeof(item.cid)}} element: {{item.element}}
                    Hover to Show Secret
                </div>
                <p v-if="!item.hovered">Secret !!!</p>
            </div>
            <div v-bind:class="(item.hovered==true)?'box foo-hover  ':'box2' " v-for="(item) in players[1].cards.slice(4, 5)" :key="item.cid" @mouseover="item.hovered = true" @mouseleave="item.hovered = false">
                <ow-popover class="popover" position="top">

                <div v-if="item.hovered==true ">
                    {{item.cid}}
                    {{typeof(item.cid)}} element: {{item.element}}
                    Hover to Show Secret
                </div>
                <p v-if="!item.hovered">Secret !!!</p>
                 <template slot="content">
                        <div>只能选择前 4 张牌</div>
                    </template>
                </ow-popover>
            </div>
        </ow-row>

        <div v-if="currPlayer === 1">
            <!-- <ow-button type="primary" @click="toAction(1, 1)">加入对方烧杯</ow-button>
                        <ow-button type="warning" @click="toAction(1, 0)">加入已方烧杯</ow-button> -->
            <ow-button type="danger" @click="toEndRound(1)">结束回合</ow-button>
            <ow-button type="danger" @click="toQuit(1)">结束游戏</ow-button>
        </div>
    </ow-footer>
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
            // 填写玩家姓名
            console.log("init player")
            var playerA = this.$store.getters.getPlayerName("a")
            var playerB = this.$store.getters.getPlayerName("b")
            console.log("player A", playerA, playerB)
            console.log("player names", this.$store.state.playerName)
            this.players[0].name = playerA
            this.players[1].name = playerB
        },
        selectCard(card, playerId, currCardId) {
            // 选中 卡牌
            const that = this
            console.log("select card", playerId, currCardId, typeof (currCardId))
            that.cardSelected = 1
            that.currCardId = currCardId
        },
        putBeakerA() {
            // 将卡牌放进 A 烧杯
            const that = this
            var currPlayer = that.currPlayer
            var currCardId = that.currCardId
            console.log("put card to beakerA", this.players[currPlayer].cards[currCardId].element)
            that.toAction(currPlayer, 0)
        },
        putBeakerB() {
            // 将卡牌放进 B 烧杯
            const that = this
            var currPlayer = that.currPlayer
            var currCardId = that.currCardId
            console.log("put card to beakerB", this.players[currPlayer].cards[currCardId].element)
            that.toAction(currPlayer, 1)
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

            // reset states
            that.isOpen = true
            that.cardSelected = 0
            that.currCardId = 99
            setTimeout(function () {
                that.isOpen = false
            }, 4000)
        },
        toEndRound(playerId) {
            // 结束回合
            var that = this
            console.log("(playerId + 1)", (playerId + 1) % 2)
            var nxtPlayer = (playerId + 1) % 2 === 0 ? 0 : 1
            that.currCardId = 99
            that.currPlayer = nxtPlayer
            that.currentRound += 1
        },
        toQuit(playerId) {
            var that = this
            var player = that.player[playerId]
            that.currAction = player.name + " 放弃了游戏"
            that.isOpen = true
            that.gameOver = true
        }
    },
    created() {
        console.log("router", this.$route.path)
        this.initPlayer()
        this.intiGame()
        // var url = "https://wx.aijuncai.com/api/client_api/client/user_by_openid"
        // this.$http.get(url, { params: { openid: "ovF374i3zwl2_6lBK5ZWq2BoIVuA" } }).then(
        //     res => {
        //         console.log(res.data)
        //     }
        // )
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
.footer {
    /* padding-top: 30px;
    padding-bottom: 20px; */
    bottom: 15%;
    position: absolute;
    left: 20%;
    right: 20%
}

.heroName {
    font-size: 2rem;
}

.content {
    color: bisque;
}

.box {
    border: 1p solid;
    border-color: black;
    /* padding: 5px; */
    width: 100px;
    height: 160px;
    color: cadetblue;
    background-color: lightblue;
    margin-left: auto;
    margin-right: auto
}

.box2 {
    border: 1p solid;
    border-color: black;
    /* padding: 5px; */
    width: 100px;
    height: 160px;
    color: cadetblue;
    background-color: lightgrey;
    margin-left: auto;
    margin-right: auto
}

.foo-hover {
    background-color: bisque;
    transform: scale(1.2);
}

.foo-selected {
    transform: scale(1);
}

.centerBox {
    border: 1p solid;
    border-color: black;
    padding: 5px;
    background-color: lightgoldenrodyellow;
    opacity: 0.5;
    color: darkgreen;
}

.box-right {
    text-align: right;
    float: right;
}

.playerNotice {
    text-align: center;
    padding-left: 0;
    padding-right: 0;
    padding-top: 40px;
}

.cards {
    padding-top: 40px;
    padding-bottom: 30px;
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

.layout {
    padding-top: 10px;
}
</style>
