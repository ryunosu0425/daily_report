<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <c:if test="${flush != null}">
            <div id="flush_success">
                <c:out value="${flush}"></c:out>
            </div>
        </c:if>
        <h2>日報 一覧</h2>
        <table id="report_list">
            <tbody>
                <tr>
                    <th class="report_name">氏名</th>
                    <th class="report_date">日付</th>
                    <th class="report_title">タイトル</th>
                    <th class="report_action">操作</th>
                    <th class="follow">フォロー</th>
                </tr>
                <c:forEach var="report" items="${reports}" varStatus="status">
                    <tr class="row${status.count % 2}">
                        <td class="report_name"><c:out
                                value="${report.employee.name}" /></td>
                        <td class="report_date"><fmt:formatDate
                                value='${report.report_date}' pattern='yyyy-MM-dd' /></td>
                        <td class="report_title">${report.title}</td>
                        <td class="report_action"><a
                            href="<c:url value='/reports/show?id=${report.id}' />">詳細を見る</a></td>

                        <c:choose>
                            <c:when
                                test="${sessionScope.login_employee.id != report.employee.id}">
                                <c:set var="flg" value="false" />
                                <c:forEach var="follow" items="${follows}">
                                    <c:choose>
                                        <c:when test="${report.employee.id == follow.follow.id}">
                                            <td>
                                                <form method="POST"
                                                    action="<c:url value='/follows/destroy' />">
                                                    <input type="hidden" name="_token" value="${_token}" />
                                                    <button type="submit" name="followed" value="${report.id}">フォロー中</button>
                                                </form>
                                            </td>
                                            <c:set var="flg" value="true" />

                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                                <c:if test="${flg == false}">
                                    <td>
                                        <form method="POST" action="<c:url value='/follows' />">
                                            <input type="hidden" name="_token" value="${_token}" />
                                            <button type="submit" name="following" value="${report.id}">フォローする</button>
                                        </form>
                                    </td>

                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <td></td>
                            </c:otherwise>

                        </c:choose>

                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div id="pagination">
            （全 ${reports_count} 件）<br />
            <c:forEach var="i" begin="1" end="${((reports_count - 1) / 15) + 1}"
                step="1">
                <c:choose>
                    <c:when test="${i == page}">
                        <c:out value="${i}" />&nbsp;
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/reports/index?page=${i}' />"><c:out
                                value="${i}" /></a>&nbsp;
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
        <p>
            <a href="<c:url value='/reports/new' />">新規日報の登録</a>
        </p>
    </c:param>
</c:import>