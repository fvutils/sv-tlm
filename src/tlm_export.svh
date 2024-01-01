/**
 * tlm_export.svh
 *
 * Copyright 2024 Matthew Ballance and Contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may 
 * not use this file except in compliance with the License.  
 * You may obtain a copy of the License at:
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software 
 * distributed under the License is distributed on an "AS IS" BASIS, 
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  
 * See the License for the specific language governing permissions and 
 * limitations under the License.
 *
 * Created on:
 *     Author: 
 */
class tlm_export #(type IF);
    IF                  m_impl;
    tlm_export #(IF)    m_exp;

    function new(IF impl=null);
        m_impl = impl;
    endfunction

    function void bind_exp(tlm_export #(IF) exp);
        m_exp = exp;
    endfunction

    function void bind_impl(IF impl);
        m_impl = impl;
    endfunction

    function IF impl();
        if (m_impl != null) begin
            return m_impl;
        end else if (m_exp != null) begin
            m_impl = m_exp.impl();
            return m_impl;
        end else begin
            $display("FATAL");
        end
    endfunction

endclass

