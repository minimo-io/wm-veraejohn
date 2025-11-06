<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet
	version="2.0"
	xmlns:html="http://www.w3.org/TR/html40"
	xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
	xmlns:image="http://www.google.com/schemas/sitemap-image/1.1"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>

	<xsl:template match="/">
		<xsl:variable name="fileType">
			<xsl:choose>
				<xsl:when test="//channel">RSS</xsl:when>
				<xsl:when test="//sitemap:url">Sitemap</xsl:when>
				<xsl:otherwise>SitemapIndex</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<title>
					<xsl:choose>
						<xsl:when test="$fileType='Sitemap' or $fileType='RSS'">do sitemap</xsl:when>
						<xsl:otherwise>Índice do sitemap</xsl:otherwise>
					</xsl:choose>
				</title>
				<meta name="viewport" content="width=device-width, initial-scale=1" />
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
				<style type="text/css">
	body {
		margin: 0;
		font-family: Helvetica, Arial, sans-serif;
		font-size: 68.5%;
	}
	#content-head {
		background-color: #141B38;
		padding: 20px 40px;
	}
	#content-head h1,
	#content-head p,
	#content-head a {
		color: #fff;
		font-size: 1.2em;
	}
	#content-head h1 {
		font-size: 2em;
	}
	table {
		margin: 20px 40px;
		border: none;
		border-collapse: collapse;
		font-size: 1em;
		width: 75%;
	}
	th {
		border-bottom: 1px solid #ccc;
		text-align: left;
		padding: 15px 5px;
		font-size: 14px;
	}
	td {
		padding: 10px 5px;
		border-left: 3px solid #fff;
	}
	tr.stripe {
		background-color: #f7f7f7;
	}
	table td a:not(.localized) {
		display: block;
	}
	table td a img {
		max-height: 30px;
		margin: 6px 3px;
	}
	.empty-sitemap {
		margin: 20px 40px;
		width: 75%;
	}
	.empty-sitemap__title {
		font-size: 18px;
		line-height: 125%;
		margin: 12px 0;
	}
	.empty-sitemap svg {
		width: 140px;
		height: 140px;
	}
	.empty-sitemap__buttons {
		margin-bottom: 30px;
	}
	.empty-sitemap__buttons .button {
		margin-right: 5px;
	}
	.breadcrumb {
		margin: 20px 40px;
		width: 75%;

		display: flex;
		align-items: center;
		font-size: 12px;
		font-weight: 600;
	}
	.breadcrumb a {
		color: #141B38;
		text-decoration: none;
	}
	.breadcrumb svg {
		margin: 0 10px;
	}
	@media (max-width: 1023px) {
		.breadcrumb svg:not(.back),
		.breadcrumb a:not(:last-of-type),
		.breadcrumb span {
			display: none;
		}
		.breadcrumb a:last-of-type::before {
			content: 'Voltar'
		}
	}
	@media (min-width: 1024px) {
		.breadcrumb {
			font-size: 14px;
		}
		.breadcrumb a {
			font-weight: 400;
		}
		.breadcrumb svg.back {
			display: none;
		}
	}
</style>
			</head>
			<body>
				<xsl:variable name="amountOfURLs">
					<xsl:choose>
						<xsl:when test="$fileType='RSS'">
							<xsl:value-of select="count(//channel/item)"></xsl:value-of>
						</xsl:when>
						<xsl:when test="$fileType='Sitemap'">
							<xsl:value-of select="count(sitemap:urlset/sitemap:url)"></xsl:value-of>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="count(sitemap:sitemapindex/sitemap:sitemap)"></xsl:value-of>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:call-template name="Header">
					<xsl:with-param name="title">do sitemap</xsl:with-param>
					<xsl:with-param name="amountOfURLs" select="$amountOfURLs"/>
					<xsl:with-param name="fileType" select="$fileType"/>
				</xsl:call-template>

				<div class="content">
					<div class="container">
						<xsl:choose>
							<xsl:when test="$amountOfURLs = 0"><xsl:call-template name="emptySitemap"/></xsl:when>
							<xsl:when test="$fileType='Sitemap'"><xsl:call-template name="sitemapTable"/></xsl:when>
							<xsl:when test="$fileType='RSS'"><xsl:call-template name="sitemapRSS"/></xsl:when>
							<xsl:otherwise><xsl:call-template name="siteindexTable"/></xsl:otherwise>
						</xsl:choose>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template name="siteindexTable">
		<div class="breadcrumb">
	<svg class="back" width="6" height="9" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5.274 7.56L2.22 4.5l3.054-3.06-.94-.94-4 4 4 4 .94-.94z" fill="#141B38"/></svg>

	<a href="https://veraejohn.com.br"><span>Início</span></a>

			<svg width="6" height="8" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M.727 7.06L3.78 4 .727.94l.94-.94 4 4-4 4-.94-.94z" fill="#141B38"/></svg>

					<span>Índice do sitemap</span>
				</div>		<div class="table-wrapper">
			<table cellpadding="3">
				<thead>
				<tr>
					<th class="left">
						URL					</th>
					<th>Quantidade de URLs</th>
					<th>
						Última atualização					</th>
				</tr>
				</thead>
				<tbody>
				<xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyz'"/>
				<xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
				<xsl:for-each select="sitemap:sitemapindex/sitemap:sitemap">
										<tr>
						<xsl:if test="position() mod 2 != 0">
							<xsl:attribute name="class">stripe</xsl:attribute>
						</xsl:if>
						<td class="left">
							<a>
								<xsl:attribute name="href">
									<xsl:value-of select="sitemap:loc" />
								</xsl:attribute>
								<xsl:value-of select="sitemap:loc"/>
							</a>
						</td>
						<td>
													</td>
						<td class="datetime">
							<div class="date">
	<xsl:choose>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-vera-amp-john/'">May 1, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/'">September 10, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/promocoes/bc-game-chuva-de-bonus-pra-fazer-chover-cripto/'">September 11, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-betwinner/'">September 11, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-slottojam/'">September 11, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-reloadbet/'">September 11, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-vbet/'">September 11, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-bc-game/'">September 11, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-mundo-apostas/'">September 11, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/slingo-cascade/'">August 20, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/superbola/'">August 20, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/calavera-bingo/'">August 20, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/7-piggies-scratch/'">August 20, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/promocoes/betwinner-no-vj-bonus-que-dobra-sua-grana-e-sua-diversao/'">September 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/promocoes/vbet-no-vj-bonus-de-boas-vindas-que-dobra-sua-diversao/'">September 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/promocoes/mundo-apostas-no-vj-bonus-de-boas-vindas-que-faz-a-festa/'">September 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/red-diamond/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/golden-leprechaun-megaways/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/wild-tome-of-the-woods/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/bamboo-rush/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/wilhelm-tell/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/dragon-strike/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/halloween-jack/'">August 19, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/lucky-halloween/'">August 19, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/past-the-post/'">August 19, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/zombie-queen/'">August 19, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/kraken-conquest/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/imperial-palace/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/banana-odyssey/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/yokozuna-clash/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/time-travel-tigers/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/legend-of-the-nile/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/bugs-party/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/the-angler/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/forever-diamonds/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/imperial-riches/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/thor-hammer-time/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/wild-pops/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/wild-joker-stacks/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/vault-of-fortune/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/winterberries/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/novidades/guia-para-escolher-o-melhor-cassino-online-no-brasil/'">May 15, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/novidades/guia-de-cassinos-online-descubra-os-melhores-jogos/'">May 15, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-bet-9-casino/'">May 1, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/novidades/domine-os-cassinos-online-com-tres-dicas-essenciais/'">May 14, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/valley-of-the-gods-2/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/tikipop/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/tiki-infinity-reels-megaways/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/thor-infinity-reels/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/the-royal-family/'">August 8, 2024</xsl:when>
			</xsl:choose>
</div>
<div class="time">
	<xsl:choose>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-vera-amp-john/'">3:27 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/'">10:06 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/promocoes/bc-game-chuva-de-bonus-pra-fazer-chover-cripto/'">8:48 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-betwinner/'">7:26 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-slottojam/'">7:19 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-reloadbet/'">7:09 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-vbet/'">6:47 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-bc-game/'">6:38 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-mundo-apostas/'">6:35 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/slingo-cascade/'">7:12 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/superbola/'">7:10 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/calavera-bingo/'">5:54 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/7-piggies-scratch/'">5:49 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/promocoes/betwinner-no-vj-bonus-que-dobra-sua-grana-e-sua-diversao/'">2:24 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/promocoes/vbet-no-vj-bonus-de-boas-vindas-que-dobra-sua-diversao/'">1:45 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/promocoes/mundo-apostas-no-vj-bonus-de-boas-vindas-que-faz-a-festa/'">1:35 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/red-diamond/'">6:38 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/golden-leprechaun-megaways/'">6:38 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/wild-tome-of-the-woods/'">6:38 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/bamboo-rush/'">6:37 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/wilhelm-tell/'">6:37 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/dragon-strike/'">6:28 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/halloween-jack/'">5:48 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/lucky-halloween/'">5:36 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/past-the-post/'">5:30 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/zombie-queen/'">5:23 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/kraken-conquest/'">6:27 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/imperial-palace/'">6:27 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/banana-odyssey/'">6:27 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/yokozuna-clash/'">6:18 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/time-travel-tigers/'">6:16 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/legend-of-the-nile/'">6:15 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/bugs-party/'">6:15 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/the-angler/'">6:14 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/forever-diamonds/'">6:09 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/imperial-riches/'">3:13 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/thor-hammer-time/'">3:04 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/wild-pops/'">2:34 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/wild-joker-stacks/'">2:29 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/vault-of-fortune/'">2:24 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/winterberries/'">2:23 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/novidades/guia-para-escolher-o-melhor-cassino-online-no-brasil/'">1:56 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/novidades/guia-de-cassinos-online-descubra-os-melhores-jogos/'">1:40 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-bet-9-casino/'">6:27 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/novidades/domine-os-cassinos-online-com-tres-dicas-essenciais/'">8:01 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/valley-of-the-gods-2/'">2:18 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/tikipop/'">2:17 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/tiki-infinity-reels-megaways/'">2:09 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/thor-infinity-reels/'">2:03 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/the-royal-family/'">1:32 pm</xsl:when>
			</xsl:choose>
</div>						</td>
					</tr>
				</xsl:for-each>
				</tbody>
			</table>
		</div>
	</xsl:template>

	<xsl:template name="sitemapRSS">
		<div class="breadcrumb">
	<svg class="back" width="6" height="9" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5.274 7.56L2.22 4.5l3.054-3.06-.94-.94-4 4 4 4 .94-.94z" fill="#141B38"/></svg>

	<a href="https://veraejohn.com.br"><span>Início</span></a>

			<svg width="6" height="8" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M.727 7.06L3.78 4 .727.94l.94-.94 4 4-4 4-.94-.94z" fill="#141B38"/></svg>

					<span>do sitemap</span>
				</div>		<div class="table-wrapper">
			<table cellpadding="3">
				<thead>
					<tr>
						<th class="left">URL</th>
						<th>
							Data de publicação						</th>
					</tr>
				</thead>
				<tbody>
				<xsl:for-each select="//channel/item">
										<tr>
						<xsl:if test="position() mod 2 != 0">
							<xsl:attribute name="class">stripe</xsl:attribute>
						</xsl:if>
						<td class="left">
							<a>
								<xsl:attribute name="href">
									<xsl:value-of select="link" />
								</xsl:attribute>
								<xsl:value-of select="link"/>
							</a>
						</td>
						<td class="datetime">
							<div class="date">
	<xsl:choose>
					<xsl:when test="link = 'https://veraejohn.com.br/casino/analise-do-casino-vera-amp-john/'">May 1, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/'">September 10, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/promocoes/bc-game-chuva-de-bonus-pra-fazer-chover-cripto/'">September 11, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/casino/analise-do-casino-betwinner/'">September 11, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/casino/analise-do-casino-slottojam/'">September 11, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/casino/analise-do-casino-reloadbet/'">September 11, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/casino/analise-do-casino-vbet/'">September 11, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/casino/analise-do-casino-bc-game/'">September 11, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/casino/analise-do-casino-mundo-apostas/'">September 11, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/slingo-cascade/'">August 20, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/superbola/'">August 20, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/calavera-bingo/'">August 20, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/7-piggies-scratch/'">August 20, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/promocoes/betwinner-no-vj-bonus-que-dobra-sua-grana-e-sua-diversao/'">September 12, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/promocoes/vbet-no-vj-bonus-de-boas-vindas-que-dobra-sua-diversao/'">September 12, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/promocoes/mundo-apostas-no-vj-bonus-de-boas-vindas-que-faz-a-festa/'">September 12, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/red-diamond/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/golden-leprechaun-megaways/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/wild-tome-of-the-woods/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/bamboo-rush/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/wilhelm-tell/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/dragon-strike/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/halloween-jack/'">August 19, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/lucky-halloween/'">August 19, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/past-the-post/'">August 19, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/zombie-queen/'">August 19, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/kraken-conquest/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/imperial-palace/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/banana-odyssey/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/yokozuna-clash/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/time-travel-tigers/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/legend-of-the-nile/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/bugs-party/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/the-angler/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/forever-diamonds/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/imperial-riches/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/thor-hammer-time/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/wild-pops/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/wild-joker-stacks/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/vault-of-fortune/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/winterberries/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/novidades/guia-para-escolher-o-melhor-cassino-online-no-brasil/'">May 15, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/novidades/guia-de-cassinos-online-descubra-os-melhores-jogos/'">May 15, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/casino/analise-do-casino-bet-9-casino/'">May 1, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/novidades/domine-os-cassinos-online-com-tres-dicas-essenciais/'">May 14, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/valley-of-the-gods-2/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/tikipop/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/tiki-infinity-reels-megaways/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/thor-infinity-reels/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/the-royal-family/'">August 8, 2024</xsl:when>
			</xsl:choose>
</div>
<div class="time">
	<xsl:choose>
					<xsl:when test="link = 'https://veraejohn.com.br/casino/analise-do-casino-vera-amp-john/'">3:27 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/'">10:06 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/promocoes/bc-game-chuva-de-bonus-pra-fazer-chover-cripto/'">8:48 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/casino/analise-do-casino-betwinner/'">7:26 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/casino/analise-do-casino-slottojam/'">7:19 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/casino/analise-do-casino-reloadbet/'">7:09 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/casino/analise-do-casino-vbet/'">6:47 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/casino/analise-do-casino-bc-game/'">6:38 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/casino/analise-do-casino-mundo-apostas/'">6:35 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/slingo-cascade/'">7:12 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/superbola/'">7:10 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/calavera-bingo/'">5:54 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/7-piggies-scratch/'">5:49 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/promocoes/betwinner-no-vj-bonus-que-dobra-sua-grana-e-sua-diversao/'">2:24 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/promocoes/vbet-no-vj-bonus-de-boas-vindas-que-dobra-sua-diversao/'">1:45 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/promocoes/mundo-apostas-no-vj-bonus-de-boas-vindas-que-faz-a-festa/'">1:35 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/red-diamond/'">6:38 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/golden-leprechaun-megaways/'">6:38 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/wild-tome-of-the-woods/'">6:38 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/bamboo-rush/'">6:37 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/wilhelm-tell/'">6:37 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/dragon-strike/'">6:28 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/halloween-jack/'">5:48 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/lucky-halloween/'">5:36 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/past-the-post/'">5:30 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/zombie-queen/'">5:23 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/kraken-conquest/'">6:27 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/imperial-palace/'">6:27 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/banana-odyssey/'">6:27 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/yokozuna-clash/'">6:18 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/time-travel-tigers/'">6:16 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/legend-of-the-nile/'">6:15 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/bugs-party/'">6:15 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/the-angler/'">6:14 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/forever-diamonds/'">6:09 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/imperial-riches/'">3:13 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/thor-hammer-time/'">3:04 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/wild-pops/'">2:34 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/wild-joker-stacks/'">2:29 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/vault-of-fortune/'">2:24 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/winterberries/'">2:23 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/novidades/guia-para-escolher-o-melhor-cassino-online-no-brasil/'">1:56 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/novidades/guia-de-cassinos-online-descubra-os-melhores-jogos/'">1:40 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/casino/analise-do-casino-bet-9-casino/'">6:27 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/novidades/domine-os-cassinos-online-com-tres-dicas-essenciais/'">8:01 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/valley-of-the-gods-2/'">2:18 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/tikipop/'">2:17 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/tiki-infinity-reels-megaways/'">2:09 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/thor-infinity-reels/'">2:03 pm</xsl:when>
					<xsl:when test="link = 'https://veraejohn.com.br/jogos/the-royal-family/'">1:32 pm</xsl:when>
			</xsl:choose>
</div>						</td>
					</tr>
				</xsl:for-each>
				</tbody>
			</table>
		</div>
	</xsl:template>

	<xsl:template name="sitemapTable">
		<div class="breadcrumb">
	<svg class="back" width="6" height="9" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5.274 7.56L2.22 4.5l3.054-3.06-.94-.94-4 4 4 4 .94-.94z" fill="#141B38"/></svg>

	<a href="https://veraejohn.com.br"><span>Início</span></a>

			<svg width="6" height="8" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M.727 7.06L3.78 4 .727.94l.94-.94 4 4-4 4-.94-.94z" fill="#141B38"/></svg>

					<a href="https://veraejohn.com.br/sitemap.xml"><span>Índice do sitemap</span></a>
						<svg width="6" height="8" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M.727 7.06L3.78 4 .727.94l.94-.94 4 4-4 4-.94-.94z" fill="#141B38"/></svg>

					<span>do sitemap</span>
				</div>		<div class="table-wrapper">
			<table cellpadding="3">
				<thead>
					<tr>
						<th class="left">
							URL						</th>
													<th>
								Imagens							</th>
												<th>
							Frequência de alteração						</th>
						<th>
							Prioridade						</th>
						<th>
							Última atualização						</th>
					</tr>
				</thead>
				<tbody>
				<xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyz'"/>
				<xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
				<xsl:for-each select="sitemap:urlset/sitemap:url">
										<tr>
						<xsl:if test="position() mod 2 != 0">
							<xsl:attribute name="class">stripe</xsl:attribute>
						</xsl:if>

						<td class="left">
							<xsl:variable name="itemURL">
								<xsl:value-of select="sitemap:loc"/>
							</xsl:variable>

							<xsl:choose>
								<xsl:when test="count(./*[@rel='alternate']) > 0">
									<xsl:for-each select="./*[@rel='alternate']">
										<xsl:if test="position() = last()">
											<a href="{current()/@href}" class="localized">
												<xsl:value-of select="@href"/>
											</a> &#160;&#8594; <xsl:value-of select="@hreflang"/>
										</xsl:if>
									</xsl:for-each>
								</xsl:when>
								<xsl:otherwise>
									<a href="{$itemURL}">
										<xsl:value-of select="sitemap:loc"/>
									</a>
								</xsl:otherwise>
							</xsl:choose>

							<xsl:for-each select="./*[@rel='alternate']">
								<br />
								<xsl:if test="position() != last()">
									<a href="{current()/@href}" class="localized">
										<xsl:value-of select="@href"/>
									</a> &#160;&#8594; <xsl:value-of select="@hreflang"/>
								</xsl:if>
							</xsl:for-each>
						</td>
												<td>
							<div class="item-count">
								<xsl:value-of select="count(image:image)"/>
							</div>
						</td>
												<td>
							<xsl:value-of select="concat(translate(substring(sitemap:changefreq, 1, 1),concat($lower, $upper),concat($upper, $lower)),substring(sitemap:changefreq, 2))"/>
						</td>
						<td>
							<xsl:if test="string(number(sitemap:priority))!='NaN'">
								<xsl:call-template name="formatPriority">
									<xsl:with-param name="priority" select="sitemap:priority"/>
								</xsl:call-template>
							</xsl:if>
						</td>
						<td class="datetime">
							<div class="date">
	<xsl:choose>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-vera-amp-john/'">May 1, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/'">September 10, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/promocoes/bc-game-chuva-de-bonus-pra-fazer-chover-cripto/'">September 11, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-betwinner/'">September 11, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-slottojam/'">September 11, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-reloadbet/'">September 11, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-vbet/'">September 11, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-bc-game/'">September 11, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-mundo-apostas/'">September 11, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/slingo-cascade/'">August 20, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/superbola/'">August 20, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/calavera-bingo/'">August 20, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/7-piggies-scratch/'">August 20, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/promocoes/betwinner-no-vj-bonus-que-dobra-sua-grana-e-sua-diversao/'">September 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/promocoes/vbet-no-vj-bonus-de-boas-vindas-que-dobra-sua-diversao/'">September 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/promocoes/mundo-apostas-no-vj-bonus-de-boas-vindas-que-faz-a-festa/'">September 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/red-diamond/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/golden-leprechaun-megaways/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/wild-tome-of-the-woods/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/bamboo-rush/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/wilhelm-tell/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/dragon-strike/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/halloween-jack/'">August 19, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/lucky-halloween/'">August 19, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/past-the-post/'">August 19, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/zombie-queen/'">August 19, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/kraken-conquest/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/imperial-palace/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/banana-odyssey/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/yokozuna-clash/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/time-travel-tigers/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/legend-of-the-nile/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/bugs-party/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/the-angler/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/forever-diamonds/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/imperial-riches/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/thor-hammer-time/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/wild-pops/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/wild-joker-stacks/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/vault-of-fortune/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/winterberries/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/novidades/guia-para-escolher-o-melhor-cassino-online-no-brasil/'">May 15, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/novidades/guia-de-cassinos-online-descubra-os-melhores-jogos/'">May 15, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-bet-9-casino/'">May 1, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/novidades/domine-os-cassinos-online-com-tres-dicas-essenciais/'">May 14, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/valley-of-the-gods-2/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/tikipop/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/tiki-infinity-reels-megaways/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/thor-infinity-reels/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/the-royal-family/'">August 8, 2024</xsl:when>
			</xsl:choose>
</div>
<div class="time">
	<xsl:choose>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-vera-amp-john/'">3:27 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/'">10:06 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/promocoes/bc-game-chuva-de-bonus-pra-fazer-chover-cripto/'">8:48 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-betwinner/'">7:26 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-slottojam/'">7:19 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-reloadbet/'">7:09 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-vbet/'">6:47 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-bc-game/'">6:38 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-mundo-apostas/'">6:35 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/slingo-cascade/'">7:12 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/superbola/'">7:10 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/calavera-bingo/'">5:54 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/7-piggies-scratch/'">5:49 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/promocoes/betwinner-no-vj-bonus-que-dobra-sua-grana-e-sua-diversao/'">2:24 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/promocoes/vbet-no-vj-bonus-de-boas-vindas-que-dobra-sua-diversao/'">1:45 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/promocoes/mundo-apostas-no-vj-bonus-de-boas-vindas-que-faz-a-festa/'">1:35 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/red-diamond/'">6:38 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/golden-leprechaun-megaways/'">6:38 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/wild-tome-of-the-woods/'">6:38 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/bamboo-rush/'">6:37 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/wilhelm-tell/'">6:37 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/dragon-strike/'">6:28 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/halloween-jack/'">5:48 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/lucky-halloween/'">5:36 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/past-the-post/'">5:30 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/zombie-queen/'">5:23 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/kraken-conquest/'">6:27 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/imperial-palace/'">6:27 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/banana-odyssey/'">6:27 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/yokozuna-clash/'">6:18 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/time-travel-tigers/'">6:16 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/legend-of-the-nile/'">6:15 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/bugs-party/'">6:15 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/the-angler/'">6:14 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/forever-diamonds/'">6:09 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/imperial-riches/'">3:13 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/thor-hammer-time/'">3:04 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/wild-pops/'">2:34 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/wild-joker-stacks/'">2:29 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/vault-of-fortune/'">2:24 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/winterberries/'">2:23 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/novidades/guia-para-escolher-o-melhor-cassino-online-no-brasil/'">1:56 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/novidades/guia-de-cassinos-online-descubra-os-melhores-jogos/'">1:40 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/casino/analise-do-casino-bet-9-casino/'">6:27 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/novidades/domine-os-cassinos-online-com-tres-dicas-essenciais/'">8:01 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/valley-of-the-gods-2/'">2:18 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/tikipop/'">2:17 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/tiki-infinity-reels-megaways/'">2:09 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/thor-infinity-reels/'">2:03 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://veraejohn.com.br/jogos/the-royal-family/'">1:32 pm</xsl:when>
			</xsl:choose>
</div>						</td>
					</tr>
				</xsl:for-each>
				</tbody>
			</table>
		</div>
			</xsl:template>

	<xsl:template name="Header">
	<xsl:param name="title"/>
	<xsl:param name="amountOfURLs"/>
	<xsl:param name="fileType"/>

	<div id="content-head">
		<h1><xsl:value-of select="$title"/></h1>
		<xsl:choose>
			<xsl:when test="$fileType='RSS'">
				<p>Gerado por <a href="https://aioseo.com/?utm_source=WordPress&#038;utm_campaign=liteplugin&#038;utm_medium=rss-sitemap" target="_blank" rel="noreferrer noopener">All in One SEO</a>, este é um Sitemap RSS, destinado a ser consumido por mecanismos de pesquisa como Google ou Bing.</p>
				<p>
					Você pode encontrar mais informações sobre Sitemaps RSS em <a href="https://www.sitemaps.org/" target="_blank" rel="noreferrer noopener">sitemaps.org</a>.				</p>
			</xsl:when>
			<xsl:otherwise>
				<p>Gerado por <a href="https://aioseo.com/?utm_source=WordPress&#038;utm_campaign=liteplugin&#038;utm_medium=rss-sitemap" target="_blank" rel="noreferrer noopener">All in One SEO</a>, este é um sitemap em XML, destinado a ser consumido por mecanismos de pesquisa como Google ou Bing.</p>
				<p>
					Você pode encontrar mais informações sobre sitemaps em XML em <a href="https://www.sitemaps.org/" target="_blank" rel="noreferrer noopener">sitemaps.org</a>.				</p>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="$amountOfURLs &gt; 0">
			<p>
				<xsl:choose>
					<xsl:when test="$fileType='Sitemap' or $fileType='RSS'">
						Este sitemap contém						<xsl:value-of select="$amountOfURLs"/>
						<xsl:choose>
							<xsl:when test="$amountOfURLs = 1">
								URL							</xsl:when>
							<xsl:otherwise>
								URLs							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						Este índice de sitemap contém						<xsl:value-of select="$amountOfURLs"/>
						<xsl:choose>
							<xsl:when test="$amountOfURLs = 1">
								sitemap							</xsl:when>
							<xsl:otherwise>
								sitemaps							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
				e foi gerado em novembro 6, 2025 às 2:34 pm			</p>
		</xsl:if>
	</div>
</xsl:template>
	<xsl:template name="formatPriority">
	<xsl:param name="priority"/>

	<xsl:variable name="priorityLevel">
		<xsl:choose>
			<xsl:when test="$priority &lt;= 0.5">low</xsl:when>
			<xsl:when test="$priority &gt;= 0.6 and $priority &lt;= 0.8">medium</xsl:when>
			<xsl:when test="$priority &gt;= 0.9">high</xsl:when>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="priorityLabel">
		<xsl:choose>
			<xsl:when test="$priorityLevel = 'low'">Baixa</xsl:when>
			<xsl:when test="$priorityLevel = 'medium'">Médio</xsl:when>
			<xsl:when test="$priorityLevel = 'high'">Alta</xsl:when>
		</xsl:choose>
	</xsl:variable>

	<div>
		<xsl:attribute name="class">
			<xsl:value-of select="concat('priority priority--', $priorityLevel)" />
		</xsl:attribute>
		<xsl:value-of select="$priorityLabel" />
	</div>
</xsl:template>
	<xsl:template name="emptySitemap">
	<div class="breadcrumb">
	<svg class="back" width="6" height="9" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5.274 7.56L2.22 4.5l3.054-3.06-.94-.94-4 4 4 4 .94-.94z" fill="#141B38"/></svg>

	<a href="https://veraejohn.com.br"><span>Início</span></a>

			<svg width="6" height="8" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M.727 7.06L3.78 4 .727.94l.94-.94 4 4-4 4-.94-.94z" fill="#141B38"/></svg>

					<span>Índice do sitemap</span>
				</div>	<div class="empty-sitemap">
		<h2 class="empty-sitemap__title">
			Algo deu errado!			<br />
			Não há nenhum post aqui		</h2>
		<div class="empty-sitemap__buttons">
			<a href="https://veraejohn.com.br" class="button">Voltar à página inicial</a>
					</div>

			</div>
	<style>
		.hand-magnifier{
			animation: hand-magnifier .8s infinite ease-in-out;
			transform-origin: center 90%;
			transform-box: fill-box;
		}
		@keyframes hand-magnifier {
			0% {
				transform: rotate(0deg);
			}
			50% {
				transform: rotate(-12deg);
			}
			100% {
				transform: rotate(0deg);
			}
		}
	</style>
</xsl:template>
</xsl:stylesheet>
<!-- permalink_structure ends with slash (/) but REQUEST_URI does not end with slash (/) -->